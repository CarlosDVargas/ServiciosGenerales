# frozen_string_literal: true

class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[show edit update destroy]

  # GET /employees or /employees.json
  def index
    @query = Employee.ransack(params[:q])
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
  end

  # GET /employees/1/edit
  def edit; end

  # POST /employees or /employees.json
  def create
    @employee = Employee.new(employee_params)
    create_user
    respond_to do |format|
      if @employee.save && @user.save
        @user.update(employee_id: @employee.id)
        format.html { redirect_to employee_url(@employee), notice: 'Employee was successfully created.' }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1 or /employees/1.json
  def update
    respond_to do |format|
      if @employee.update(employee_params)
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

  # Falta documentación
  def status_filter; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_employee
    @employee = Employee.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def employee_params
    params.require(:employee).permit(:employee_id_card, :employee_status, user_account: %i[name email])
  end

  def create_user
    @user = UserAccount.new
    @user.email = params[:employee][:user_accounts][:email]
    @user.password = "Contra#{@employee.employee_id_card}"
    @user.name = params[:employee][:user_accounts][:name]
    @user.role = 'employee'
  end
end
