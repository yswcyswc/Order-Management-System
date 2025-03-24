require "test_helper"

class UserTest < ActiveSupport::TestCase
  should have_one(:employee)
  should have_one(:customer)
  should have_secure_password

  should validate_presence_of(:username)
  should validate_presence_of(:role)
  
  should allow_value(1).for(:role)
  should allow_value(2).for(:role)
  should allow_value(3).for(:role)
  should allow_value(4).for(:role)
  should allow_value("customer").for(:role)
  should allow_value("baker").for(:role)
  should allow_value("shipper").for(:role)
  should allow_value("manager").for(:role)
  should_not allow_value(nil).for(:role)

  # context
  context "Within context" do
    setup do
      create_employee_users
    end

    # Testing validations in the User model
    should "require users to have unique, case-insensitive usernames" do
      assert_equal "mark", @u_mark.username
      # try to switch to Alex's username 'tank', but capitalized
      @u_mark.username = "TANK"
      deny @u_mark.valid?, "#{@u_mark.username}"
    end

    should "require a password for new users" do
      bad_user = FactoryBot.build(:user, username: "wheezy", password: nil)
      deny bad_user.valid?
    end
    
    should "require passwords to be confirmed and matching" do
      bad_user_1 = FactoryBot.build(:user, username: "wheezy", password: "secret", password_confirmation: nil)
      deny bad_user_1.valid?
      bad_user_2 = FactoryBot.build(:user, username: "wheezy", password: "secret", password_confirmation: "sauce")
      deny bad_user_2.valid?
    end
    
    should "require passwords to be at least four characters" do
      bad_user = FactoryBot.build(:user, username: "wheezy", password: "no", password_confirmation: "no")
      deny bad_user.valid?
    end

    # Testing other methods within the User model
    should "have make_active and make_inactive methods" do
      assert @u_mark.active
      @u_mark.make_inactive
      @u_mark.reload
      deny @u_mark.active
      @u_mark.make_active
      @u_mark.reload
      assert @u_mark.active
    end

    should "not allow users to be destroyed" do
      deny @u_mark.destroy
    end

  end
  
end
