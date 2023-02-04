# frozen_string_literal: true

class RequestsController < ApplicationController
  before_action :set_request, only: %i[show edit update destroy change_status]
  before_action :set_campuses_list, only: %i[new create]
  before_action :set_dictionary, only: %i[new show edit update index create search]
  before_action :set_status, only: %i[show]

  # GET /requests or /requests.json
  def index
    @requests = Request.where(campus: current_user_account.employee.campus)
    @queries = @requests.ransack(params[:q])
    @requests = @queries.result
    @status = params[:status] if params[:status]
    return if params[:q].present?

    set_status
    set_requests
  end

  def search
    index
    render :reports
  end

  # GET /requests/1 or /requests/1.json
  def show
    @reasons = RequestDenyReason.where(request_id: @request.id) if @request.status == 'denied'
  end

  # GET /requests/new
  def new
    @request = Request.new
  end

  # GET /requests/1/edit
  def edit; end

  # POST /requests or /requests.json
  def create
    @request = Request.new(request_params)
    campus = params[:request][:campus_id]
    @request.status = 'pending'
    @request.campus = Campus.find(campus)
    date = Time.now.strftime('%d%m%Y')
    @request.identifier = "#{@request.campus.campus_id}-#{date}-#{rand.to_s[2..6]}"
    unless params[:request][:work_location_id] == '0'
      request_location = RequestLocation.new
      work_location = params[:request][:work_location].to_i
      request_location.work_building = WorkBuilding.find(params[:request][:work_building])
      if work_location.zero?
        request_location.name = params[:request][:work_location]
      else
        work_location = WorkLocation.find(work_location)
        request_location.work_location = work_location
        request_location.name = work_location.name
      end
    end
    respond_to do |format|
      if @request.save
        request_location.request = @request
        request_location.save
        RequestMailer.new_request(@request).deliver_later
        format.html { redirect_to request_url(@request), notice: 'La solicitud fue creada correctamente.' }
        format.json { render :show, status: :created, location: @request }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /requests/1 or /requests/1.json
  # @return [Object]
  def update
    respond_to do |format|
      reasons_array = deny_reasons
      if reasons_array
        reasons_array.each do |reason|
          RequestDenyReason.create(reason: reason[:reason], user_account: current_user_account, request: @request)
        end
        @request.update(status: 'denied')
        @log_entry = LogEntry.create(user_account: current_user_account, request: @request,
                                     entry_message: 'Denegó la solicitud')
        RequestMailer.request_denied(@request).deliver_later
        format.html { redirect_to requests_url, notice: 'Se actualizó el estado de la solicitud' }
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @request.errors }
      end
    end
  end

  # Encharged of updating the status of a request depending on the status obtained from the params
  def change_status
    status = @request.status
    case status
    when 'in_process'
      set_task
      @task.update(status: 'completed')
      if analyse_tasks
        @request.update(status: 'completed')
        @log_entry = LogEntry.create(user_account: current_user_account, request: @request,
                                     entry_message: 'Cambió el estado de la solicitud a completada')
      end
      reload_index
    when 'completed'
      if params[:change_to] == 'close'
        @request.update(status: 'closed')
        @log_entry = LogEntry.create(user_account: current_user_account, request: @request,
                                     entry_message: 'Cambió el estado de la solicitud a cerrada')
        RequestMailer.request_completed(@request).deliver_now
      else
        reset_tasks
        @request.update(status: 'in_process')
        @log_entry = LogEntry.create(user_account: current_user_account, request: @request,
                                     entry_message: 'Cambió el estado de la solicitud a en proceso')
      end
      reload_index
    else
      redirect_to new_task_path(request: @request)
    end
  end

  # Falta documentación
  def ask_state; end

  # Falta documentación
  def search_state
    if params[:session][:identifier] && params[:session][:requester_email]
      @request = Request.where(identifier: params[:session][:identifier],
                               requester_mail: params[:session][:requester_email]).first
    end
    if !@request.nil?
      session[:request_id] = @request.id
      redirect_to request_url(@request)
    else
      render 'ask_state'
    end
  end

  def work_buildings
    work_buildings = WorkBuilding.all.order(name: :asc)
    render json: work_buildings.to_json(include: :work_locations)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_request
    @request = Request.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def request_params
    params.require(:request).permit(:idenfifier, :requester_name, :requester_extension, :requester_phone, :requester_id,
                                    :requester_mail, :requester_type, :student_id, :student_association, :campus_id,
                                    :work_building, :work_location, :work_type, :work_description, :status,
                                    :task_id, :change_to,
                                    request_deny_reasons: %i[_destroy description request_id user_id])
  end

  # Initializes the dictionary with the default values
  def set_dictionary
    @dictionary = Dictionary.new
  end

  # Initializes the list of campuses
  def set_campuses_list
    @campuses_list = Campus.all
  end

  # Initializes the status of a request
  def set_status
    @status = params[:status]
  end

  # Set the requests depending the user role and the status of the request
  # @return [Object]
  def set_requests
    # Case for the employee
    if current_user_account.role == 'employee'
      employee = Employee.find_by(user_account: current_user_account)
      employee_requests = employee.active_requests
      @requests = case @status
                  when 'completed'
                    find_requests(employee_requests, 'completed')
                  when 'closed'
                    find_requests(employee_requests, 'closed')
                  else
                    find_requests(employee_requests, 'in_process')
                  end

      # Case for the admin
    else
      requests = Request.where(campus: current_user_account.employee.campus)
      @requests = case @status
                  when 'in_process'
                    find_requests(requests, 'in_process')
                  when 'completed'
                    find_requests(requests, 'completed')
                  when 'closed'
                    find_requests(requests, 'closed')
                  when 'denied'
                    find_requests(requests, 'denied')
                  else
                    find_requests(requests, 'pending')
                  end
    end
  end

  # Take the requests from given set: <b>set</b> depending the status: <b>status</b> of the request
  def find_requests(set, status)
    set.where(status:)
  end

  # Takes the tasks from table <b>Task</b>
  def set_task
    @task = Task.find(params[:task_id])
  end

  # Sets the completed? attribute of the tasks of the request to false
  def reset_tasks
    tasks = @request.tasks
    tasks.each do |task|
      task.update(status: 'pending')
    end
  end

  # Return the deny reasons of a request
  def deny_reasons
    params[:request][:request_deny_reasons_attributes].values if params[:request]
  end

  # Depending the value of the completed? attribute of the tasks of the current request,
  # will return true if all the tasks are completed, or false if at least one task is not completed
  def analyse_tasks
    tasks = @request.tasks
    tasks.each do |task|
      return false if task.status == 'pending'
    end
    true
  end

  # Reload the requests listing view, and informs the user that the request was successfully updated
  def reload_index
    redirect_to requests_path, notice: 'Se actualizó el estado de la solicitud'
  end

  def reports
    search
  end
end
