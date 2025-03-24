require "test_helper"

class EmployeeScopeTest < ActiveSupport::TestCase
  context "Within context" do
    setup do 
      create_employee_users
      create_employees
    end

    should "show that scope exists for alphabeticizing employees" do
      assert_equal ["Crawford", "Heimann", "Waldo", "Wilson"], Employee.alphabetical.all.map(&:last_name)
    end

    should "show that there are three active employees" do
      assert_equal ["Crawford", "Heimann", "Wilson"], Employee.active.all.map(&:last_name).sort
    end

    should "show that there is one inactive employee" do
      assert_equal ["Waldo"], Employee.inactive.all.map(&:last_name).sort
    end
  end
  
end