require 'test_helper'

class UserAuthenticationTest < ActiveSupport::TestCase
# Context
  context "Within context" do
    setup do
      create_employee_users
      create_customer_users
    end

    should "have class method to handle authentication services" do
      assert User.authenticate('tank', 'secret')
      deny User.authenticate('tank', 'notsecret')
    end

    should "have instance method to handle authentication services" do
      assert_equal @u_alexe, @u_alexe.authenticate('secret')
      deny @u_alexe.authenticate('notsecret')
    end

    should "have role methods and recognize all three roles" do
      assert @u_alexe.customer_role? # should be a customer
      deny @u_alexe.manager_role?
      deny @u_alexe.baker_role?
      deny @u_alexe.shipper_role?

      deny @u_mark.customer_role? 
      assert @u_mark.manager_role? # should be a manager
      deny @u_mark.baker_role?
      deny @u_mark.shipper_role?

      deny @u_cindy.customer_role? 
      deny @u_cindy.manager_role?
      assert @u_cindy.baker_role?  # should be a baker
      deny @u_cindy.shipper_role?

      deny @u_ralph.customer_role? 
      deny @u_ralph.manager_role?
      deny @u_ralph.baker_role?
      assert @u_ralph.shipper_role? # should be a shipper
    end

  end
end
