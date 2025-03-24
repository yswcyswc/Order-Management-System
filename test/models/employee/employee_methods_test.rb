require "test_helper"

class EmployeeMethodsTest < ActiveSupport::TestCase
  context "Within context" do
    setup do 
      create_employee_users
      create_employees
    end

    should "shows name as last, first name" do
      assert_equal "Heimann, Mark", @mark.name
    end   
    
    should "shows proper name as first and last name" do
      assert_equal "Mark Heimann", @mark.proper_name
    end 

    should "shows that Cindy Crawford's ssn is stripped of non-digits" do
      assert_equal "084359822", @cindy.ssn
    end

    should "correctly assess that an employee is not destroyable" do
      deny @mark.destroy
    end

    should "deactivate the user if the employee is made inactive" do
      assert @cindy.active
      assert @u_cindy.active
      @cindy.active = false
      @cindy.save!
      @cindy.reload
      @u_cindy.reload
      deny @cindy.active
      deny @u_cindy.active
    end 

    should "have make_active and make_inactive methods" do
      assert @cindy.active
      @cindy.make_inactive
      @cindy.reload
      deny @cindy.active
      @cindy.make_active
      @cindy.reload
      assert @cindy.active
    end

  end
end