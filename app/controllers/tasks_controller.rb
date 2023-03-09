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
    if current_user_account
      set_task
    else
      return_to_root('No tienes permisos para acceder a esta página')
    end
  end

  # POST /tasks or /tasks.json
  def create
    set_employees_for_create
    user = current_user_account
    @request = if params[:task].present?
                 Request.find(params[:task][:request_id])
               else
                 Request.find(params[:request_id])
               end
    if @request.tasks.empty?
      Task.create(user_account_id: user.id, request_id: @request.id, status: 'admin')
    end
    @employees&.each do |user_account_id|
      task = Task.find_by(user_account_id:, request_id: @request.id)
      worker = UserAccount.find(user_account_id)
      if task.nil?
        Task.create(user_account_id:, request_id: @request.id)
        UserMailer.request_assigned(@request, worker).deliver_later
      else
        task.active = true
        task.save
        UserMailer.request_reassigned(@request, worker).deliver_later
      end
      LogEntry.create(user_account: current_user_account, request: @request,
                      entry_message: "#{user.name} asignó a #{worker.name} a la solicitud")
    end
    if @request.status == 'pending'
      RequestMailer.request_accepted(@request).deliver_later
      @request.update(status: 'in_process')
      @log_entry = LogEntry.create(user_account: current_user_account, request: @request,
                                   entry_message: "#{user.name} cambió el estado de la solicitud a en proceso")
      redirect_to requests_path(:status => "pending")
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    set_task
    if params[:task][:observations].present? && params[:task][:observations][:description].present?
      description = params[:task][:observations][:description]
      if description.length.positive?
        TaskObservation.create(task_id: @task.id, user_account: current_user_account,
                               description:)
      end
    end
    if !set_employees_for_destroy.nil?
      @employees&.each do |user_account_id|
        task = Task.find_by(user_account_id:, request_id: @request.id)
        task.active = false
        task.save
        worker = UserAccount.find(user_account_id)
        UserMailer.request_removed(@request, worker).deliver_later
        LogEntry.create(user_account: current_user_account, request: @request,
                        entry_message: "#{current_user_account.name} eliminó a #{worker.name} de la solicitud")
      end
    elsif !set_employees_for_create.nil?
      create
    end
    redirect_to edit_task_path(request => @request)
  end

  # Falta documentar
  def register_request_action
    # newAction = ActionController::Parameters.new(request_id: @request.id, user_id: current_user_account.id).permit(:request_id, :user_id)
    # @request_action = RequestAction.new(newAction)
  end

  private

  # Take the task from the Task table depending the request_id and employee_id
  def set_task
    user_account_id = current_user_account.id
    if @request.nil?
      if params[:task][:request_id].present?
        @request = Request.find(params[:task][:request_id])
      elsif params[:task][:request].present?
        @request = Request.find(params[:task][:request])
      end
    end
    @task = Task.where(user_account_id:, request_id: @request.id).first
  end

  # Find the request using the request_id from the params
  def set_request
    @request = Request.find(params[:request])
  end

  # Take all the employees from the Employee table
  def set_employees
    @working_employees = @request.employees_currently_working
    @not_working_employees = @request.employees_not_working
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
