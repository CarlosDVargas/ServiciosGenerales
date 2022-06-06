class RequestsController < ApplicationController
  before_action :set_request, only: %i[ show edit update destroy  ]
  before_action :set_dictionary, only: %i[new show edit update index create]
  before_action :set_status, only: %i[index show]

  # GET /requests or /requests.json
  def index
    set_requests
  end

  # GET /requests/1 or /requests/1.json
  def show
  end

  # GET /requests/new
  def new

  end

  # GET /requests/1/edit
  def edit
  end

  # POST /requests or /requests.json
  def create
    @request = Request.new(request_params)
    @request.status = "pending"
    respond_to do |format|
      if @request.save
        format.html { redirect_to request_url(@request), notice: 'La solicitud fue creada correctamente.' }
        format.json { render :show, status: :created, location: @request }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /requests/1 or /requests/1.json
  def update
    respond_to do |format|
      if @request.update(request_params)
        format.html { redirect_to request_url(@request), notice: 'La solicitud fue actualizada correctamente.' }
        format.json { render :show, status: :ok, location: @request }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/1 or /requests/1.json
  def destroy
    @request.destroy

    respond_to do |format|
      format.html { redirect_to requests_url, notice: "La solicitud fue eliminada correctamente." }
      format.json { head :no_content }
    end
  end

  # Encharged of updating the status of a request depending on the status obtained from the params
  def change_status
    status = @request.status
    case status
    when "in_process"
      set_task
      @task.update(completed?: true)
      if analyse_tasks
        @request.update(status: "completed")
      end
      reload_index()
    when "completed"
      if params[:action] == "close"
        @request.update(status: "closed")
      else
        reset_tasks
        @request.update(status: "in_process")
      end
      reload_index()
    else
      @request.update(status: "in_process")
      redirect_to new_task_path(:request => @request)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request
      @request = Request.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def request_params
      params.require(:request).permit(:requester_name, :requester_extension, :requester_phone, :requester_id, :requester_mail, :requester_type, :student_id, :student_assosiation, :work_location, :work_building, :work_type, :work_description, :status)
    end

    # Initializes the dictionary with the default values
  def set_dictionary
    @dictionary = Dictionary.new
  end

  # Initializes the status of a request
  def set_status
    @status = params[:status]
  end

  # Set the requests depending the user role and the status of the request
  def set_requests

    # Case for the employee
    if current_user_account.role == "employee"
      #employee = Employee.where(user_id: current_user).first
      #employee_requests = employee.requests
      #case @status
      #when "completed"
      #  @requests = find_requests(employee_requests, "completed")
      #when "closed"
      #  @requests = find_requests(employee_requests, "closed")
      #else
      #  @requests = find_requests(employee_requests, "in_process")
      #end

    # Case for the admin
    else
      case @status
      when "in_process"
        @requests = find_requests(Request.all, "in_process")
      when "completed"
        @requests = find_requests(Request.all, "completed")
      when "closed"
        @requests = find_requests(Request.all, "closed")
      when "denied"
        @requests = find_requests(Request.all, "denied")
      else
        @requests = find_requests(Request.all, "pending")
      end
    end
  end

  # Take the requests from given set: <b>set</b> depending the status: <b>status</b> of the request
  def find_requests(set, status)
    set.where(status: status)
  end
end
