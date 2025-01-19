class EmployeesController < ApplicationController
  before_action :authenticate_user!

  def index
    @employees = EmployeeService.fetch_employees(page: params[:page])
  end

  def edit
    @employee = EmployeeService.fetch_employee(params[:id])
  end

  def show
    @employee = EmployeeService.fetch_employee(params[:id])
  end

  def create
    @employee = EmployeeService.create_employee(employee_params)

    if @employee
      redirect_to employee_path(@employee.dig('id'))
    else
      flash[:error] = 'Failed to create employee'
      render :new
    end
  end

  def update
    @employee = EmployeeService.update_employee(params[:id], employee_params)

    if @employee
      redirect_to edit_employee_path(@employee.dig('id'))
    else
      flash[:error] = 'Failed to update employee'
      render :edit
    end
  end

  private

  def employee_params
    params.permit(:name, :position, :date_of_birth, :salary)
  end
end
