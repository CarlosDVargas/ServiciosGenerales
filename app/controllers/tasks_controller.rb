# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_request, only: %i[new edit]
  before_action :set_employees, only: %i[new edit]
  before_action :set_dictionary, only: %i[edit]
  after_action :register_request_action, only: %i[new edit]

  # GET /tasks or /tasks.json
  def index
    @tasks = Task.all
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/edit
  def edit
    if current_user_account.role == 'employee'
      set_task
      set_observations
    end
  end

  # POST /tasks or /tasks.json
  def create
    set_employees_for_create
    @request = if params[:task].present?
                 Request.find(params[:task][:request_id])
               else
                 Request.find(params[:request_id])
               end
    @employees&.each do |employee_id|
      Task.create(employee_id:, request_id: @request.id)
      @employee = Employee.find(employee_id)
      LogEntry.create(user_account: current_user_account, request: @request,
                      entry_message: "Asignó a #{@employee.user_account.name} a la solicitud")
    end
    if @request.status == 'pending'
      @request.update(status: 'in_process')
    end
    @log_entry = LogEntry.create(user_account: current_user_account, request: @request,
                                 entry_message: 'Cambió el estado de la solicitud a en proceso')
    redirect_to requests_path
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    if current_user_account.role == 'employee'
      set_task
      description = params[:task][:observations][:description]
      if description.length.positive?
        observation = TaskObservation.create(task_id: @task.id, user_account: current_user_account,
                                             description:)
      end
      redirect_to edit_task_path(request => @request)
    elsif !set_employees_for_destroy.nil?
      @request = Request.find(params[:request_id])
      @employees&.each do |employee_id|
        task = Task.where(employee_id: Integer(employee_id), request_id: @request.id)
        task.destroy_all
        @employee = Employee.find(employee_id)
        LogEntry.create(user_account: current_user_account, request: @request,
                        entry_message: "Eliminó a #{@employee.user_account.name} de la solicitud")
      end
    elsif !set_employees_for_create.nil?
      create
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # Falta documentar
  def register_request_action
    # newAction = ActionController::Parameters.new(request_id: @request.id, user_id: current_user_account.id).permit(:request_id, :user_id)
    # @request_action = RequestAction.new(newAction)
  end

  private

  # Use callbacks to share common setup or constraints between actions.

  # Take observations from Observation table depending the task_id and user_id
  def set_observations
    @observations = TaskObservation.where(task_id: @task.id, user_account: current_user_account)
  end

  # Take the task from the Task table depending the request_id and employee_id
  def set_task
    employee_id = current_user_account.employee_id
    @request = Request.find(params[:task][:request]) if @request.nil?
    @task = Task.where(employee_id:, request_id: @request.id).first
  end

  # Find the request using the request_id from the params
  def set_request
    @request = Request.find(params[:request])
  end

  # Take an especific employee from the Employee table depending the user_id
  def employee(id)
    @employee = Employee.find(id)
  end

  # Take all the employees from the Employee table
  def set_employees
    @employees = Employee.where(employee_type: 'Trabajador')
  end

  # Take the employees from the Employee table depending the ids from employees to add
  def set_employees_for_create
    @employees = params[:selected_employees_to_add]
  end

  # Take the employees from the Employee table depending the ids from employees to remove
  def set_employees_for_destroy
    @employees = params[:selected_employees_to_remove]
  end

  # Create a new dictionary instance
  def set_dictionary
    @dictionary = Dictionary.new
  end

  # Only allow a list of trusted parameters through.
  def task_params
    params.require(:task).permit(:employee_id, :request_id, :selected_employees[], employees: [:id],
                                                                                   observations: [:description])
  end
end
