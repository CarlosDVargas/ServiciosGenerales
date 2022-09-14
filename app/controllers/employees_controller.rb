# frozen_string_literal: true

# EmployeesController
class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[show edit update destroy]
  before_action :set_user_account, only: %i[show edit update destroy]
  before_action :type_params, only: %i[new create index]

  # GET /employees or /employees.json
  def index
    @type ||= params[:q][:employee_type_eq]
    @employees_selected = if @type == 'worker'
                            Employee.where(employee_type: 'Trabajador')
                          else
                            Employee.where(employee_type: 'Administrador')
                          end
    @query = @employees_selected.ransack(params[:q])
    @employees = @query.result
  end

  def search
    index
    render :index
  end

  # GET /employees/1 or /employees/1.json
  def show; end

  # GET /employees/new
  def new
    @employee = Employee.new
    @employee.build_user_account
    @employee.employee_type = if @type == 'worker'
                                'Trabajador'
                              else
                                'Administrador'
                              end
  end

  # GET /employees/1/edit
  def edit; end

  # POST /employees or /employees.json
  # @return [Object] Employee
  def create
    byebug
    @employee = Employee.new(employee_params)
    create_user
    respond_to do |format|
      if @employee.save
        @user.employee = @employee
        @user.save
        format.html { redirect_to employee_url(@employee), notice: 'Employee was successfully created.' }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1 or /employees/1.json
  # @return [Object] Employee
  def update
    respond_to do |format|
      if @employee.update(employee_params)
        @user = @employee.user_account
        @user.update(employee_params[:user_account_attributes])
        format.html { redirect_to employee_url(@employee), notice: 'Employee was successfully updated.' }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1 or /employees/1.json
  def destroy
    if @employee.tasks.empty?
      @employee.destroy

      respond_to do |format|
        format.html { redirect_to employees_url, notice: 'Empleado eliminado correctamente.' }
        format.json { head :no_content }
      end
    else
      redirect_to '#', notice: 'No se puede eliminar un trabajador que haya sido asignado a una solicitud'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_employee
    @employee = Employee.find(params[:id])
  end

  # Set the user account for the employee
  def set_user_account
    @user_account = @employee.user_account
  end

  # Set the type of employee
  def type_params
    @type = params[:type]
  end

  # Only allow a list of trusted parameters through.
  def employee_params
    params.require(:employee).permit(:employee_id_card, :employee_status, :employee_type,
                                     user_account_attributes: %i[id name email])
  end

  # Create the user account for the employee recently created
  def create_user
    @user = UserAccount.new
    @user.email = params[:employee][:user_account_attributes][:email]
    @user.password = "Contra#{@employee.employee_id_card}"
    @user.name = params[:employee][:user_account_attributes][:name]
    @user.role = if @employee.employee_type == 'Trabajador'
                   'employee'
                 else
                   'admin'
                 end
  end
end
