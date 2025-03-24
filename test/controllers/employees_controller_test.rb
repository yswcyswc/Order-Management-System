require "test_helper"

class EmployeesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as(:manager)
    @user_employee = FactoryBot.create(:user, username: 'rachel', role: 'baker')
    @employee = FactoryBot.create(:employee, first_name: 'Rachel', user: @user_employee)
  end

  test "should get index" do
    get employees_path
    assert_response :success
    assert_not_nil assigns(:active_employees)
    assert_not_nil assigns(:inactive_employees)
  end

  test "should get new" do
    get new_employee_path
    assert_response :success
  end

  test "should create employee if valid" do
    assert_difference('Employee.count') do
      post employees_path, params: { employee: { active: true, first_name: "Ted", last_name: "Gruberman", ssn: "064-82-9186", date_hired: Date.current, date_terminated: nil, user_attributes: {username: "ted", password: "secret", password_confirmation: "secret", role: "customer"} } }
    end
    assert_equal "Ted Gruberman was added to the system.", flash[:notice]
    assert_redirected_to employee_path(Employee.last)
  end

  test "should not create employee if invalid" do
    post employees_path, params: { employee: { active: true, first_name: "Ted", last_name: "Gruberman", ssn: nil, date_hired: Date.current, date_terminated: nil, user_attributes: {username: "ted", password: "secret", password_confirmation: "secret", role: "customer"} } }
    assert_template :new
  end

  test "should not create employee without valid user" do
    post employees_path, params: { employee: { active: true, first_name: "Ted", last_name: "Gruberman", ssn: "064-82-9186", date_hired: Date.current, date_terminated: nil } }
    assert_template :new
  end

  test "should show employee" do
    get employee_path(@employee)
    assert_not_nil assigns(:employee)
    assert_response :success
  end

  test "should get edit" do
    get edit_employee_path(@employee)
    assert_response :success
  end

  test "should update employee if valid" do
    patch employee_path(@employee), params: { employee: { active: true, first_name: "Kelly", last_name: @employee.last_name, ssn: @employee.ssn, date_hired: @employee.date_hired, date_terminated: @employee.date_terminated } }
    assert_equal "Kelly Heimann was revised in the system.", flash[:notice]
    assert_redirected_to employee_path(@employee)
  end

  test "should not update employee if invalid" do
    patch employee_path(@employee), params: { employee: { active: true, first_name: "Kelly", last_name: @employee.last_name, ssn: nil, date_hired: @employee.date_hired, date_terminated: @employee.date_terminated } }
    assert_template :edit
  end

  test "should allow employees to edit first, last names" do
    logout_now
    login_user(@user_employee)
    patch employee_path(@employee), params: { employee: { active: true, first_name: "Kelli", last_name: @employee.last_name } }
    assert_redirected_to employee_path(@employee)
  end

  test "should not allow employees to edit ssn or dates" do
    logout_now
    login_user(@user_employee)
      initial_ssn = @employee.ssn
      initial_date_hired = @employee.date_hired
      initial_date_terminated = @employee.date_terminated

    patch employee_path(@employee), params: { employee: { active: true, first_name: "Kelli", last_name: @employee.last_name, ssn: "064-82-9186", date_hired: @employee.date_hired, date_terminated: @employee.date_terminated } }
    @employee.reload
    deny @employee.ssn == "064-82-9186"
    assert @employee.ssn == initial_ssn

    patch employee_path(@employee), params: { employee: { active: true, first_name: "Kelli", last_name: @employee.last_name, ssn: @employee.ssn, date_hired: 1.year.ago.to_date, date_terminated: @employee.date_terminated } }
    @employee.reload
    deny @employee.date_hired == 1.year.ago.to_date
    assert @employee.date_hired == initial_date_hired
    
    patch employee_path(@employee), params: { employee: { active: true, first_name: "Kelli", last_name: @employee.last_name, ssn: @employee.ssn, date_hired: @employee.date_hired, date_terminated: 1.month.ago.to_date } }
    @employee.reload
    deny @employee.date_terminated == 1.month.ago.to_date
    assert @employee.date_terminated == initial_date_terminated
  end

  test "should not have route for destroy nor should controller respond to destroy" do
    assert_raise ActionController::UrlGenerationError do get url_for(controller: "employees", action: "destroy", id: "#{@employee.id}") end
    deny EmployeesController.new.respond_to?(:destroy)
  end
end

