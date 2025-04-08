class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update]
  before_action :check_login
  authorize_resource

  def index
    @active_employees = Employee.active.alphabetical.to_a
    @inactive_employees = Employee.inactive.alphabetical.to_a
  end

  def show
    # set_employee sets @employee
  end

  def new
    @employee = Employee.new
    @employee.build_user
  end

  def create
    @employee = Employee.new(employee_params)

    if @employee.save
      flash[:notice] = "#{@employee.proper_name} was added to the system."
      redirect_to employee_path(@employee)
    else
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if current_user.role == "baker" || current_user.role == "shipper"
      success = @employee.update(params.require(:employee).permit(:first_name, :last_name, :active))
    else
      success = @employee.update(employee_params)
    end
  
    if success
      flash[:notice] = "#{@employee.proper_name} was revised in the system."
      redirect_to employee_path(@employee)
    else
      render action: 'edit'
    end
  end
  

  private

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(
      :first_name, :last_name, :ssn, :date_hired, :date_terminated, :active,
      user_attributes: [:username, :password, :password_confirmation, :role]
    )
  end
end
