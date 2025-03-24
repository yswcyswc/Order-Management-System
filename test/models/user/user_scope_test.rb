require "test_helper"

class UserScopeTest < ActiveSupport::TestCase

  # context
  context "Within context" do
    setup do
      create_employee_users
    end

    should "have a working scope called active" do
      assert_equal ["chuck", "cindy", "mark", "ralph", "tank"], User.active.all.map(&:username).sort
    end

    should "have a working scope called inactive" do
      assert_equal ["terry"], User.inactive.all.map(&:username).sort
    end

    should "have a working scope called employees" do
      create_customer_users
      assert @u_alexe.active  # make sure there is one active customer in the mix of users
      assert_equal ["chuck", "cindy", "mark", "ralph", "tank", "terry"], User.employees.all.map(&:username).sort
      destroy_customer_users
    end

    should "have a working scope called alphabetical" do
      assert_equal ["chuck", "cindy", "mark", "ralph", "tank", "terry"], User.alphabetical.all.map(&:username)
    end

    should "have a working scope called customer_role" do
      create_customer_users
      assert_equal [@u_alexe, @u_anthony, @u_melanie, @u_ryan, @u_sherry], User.customer_role.sort_by{ |u| u.username }
      destroy_customer_users
    end

    should "have a working scope called manager_role" do
      assert_equal [@u_mark, @u_alex], User.manager_role.sort_by{ |u| u.username }
    end

    should "have a working scope called shipper_role" do
      assert_equal [@u_chuck, @u_ralph], User.shipper_role.sort_by{ |u| u.username }
    end

    should "have a working scope called baker_role" do
      assert_equal [@u_cindy, @u_terry], User.baker_role.sort_by{ |u| u.username }
    end
  end
end
