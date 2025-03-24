require "test_helper"

class EmployeeTest < ActiveSupport::TestCase
  # test relationships
  should belong_to(:user)
  should accept_nested_attributes_for(:user).allow_destroy(true)

  # test simple validations
  should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)
  should validate_presence_of(:ssn)
  should validate_presence_of(:date_hired)

  should allow_value("123456789").for(:ssn)
  should allow_value("123-45-6789").for(:ssn)
  should allow_value("123 45 6789").for(:ssn)
  should_not allow_value("12345678").for(:ssn)
  should_not allow_value("1234567890").for(:ssn)
  should_not allow_value("bad").for(:ssn)
  should_not allow_value(nil).for(:ssn)

  should allow_value(7.weeks.ago.to_date).for(:date_hired)
  should allow_value(2.years.ago.to_date).for(:date_hired)
  should_not allow_value(1.week.from_now.to_date).for(:date_hired)
  should_not allow_value("bad").for(:date_hired)
  should_not allow_value(nil).for(:date_hired)

  context "Within context" do
    setup do 
      create_employee_users
      create_employees
    end

    should "require employees to have unique, ssn" do
      assert_equal "084359822", @cindy.ssn
      @ralph.ssn = "084359822"
      deny @ralph.valid?, "#{@ralph.ssn}"
    end

    should "allow for a end date in the past (or today) but after the date hired" do
      new_user = FactoryBot.create(:user, username: "brett", role: "baker")
      fired_today = FactoryBot.build(:employee, user: new_user, first_name: "Brett", last_name: "Cooper", ssn: "084-35-9822", date_hired: 2.weeks.ago.to_date, date_terminated: Date.current)
      assert fired_today.valid?
      fired_yesterday = FactoryBot.build(:employee, user: new_user, first_name: "Brett", last_name: "Cooper", ssn: "084-35-9823", date_hired: 2.weeks.ago.to_date, date_terminated: 1.day.ago.to_date)
      assert fired_yesterday.valid?
    end
    
    should "not allow for a end date in the future or before the start date" do
      new_user = FactoryBot.create(:user, username: "brett", role: "baker")
      fired_tomorrow = FactoryBot.build(:employee, user: new_user, first_name: "Brett", last_name: "Cooper", ssn: "084-35-9822", date_hired: 2.weeks.ago.to_date, date_terminated: 1.day.from_now.to_date)
      deny fired_tomorrow.valid?
      fired_before_hired = FactoryBot.build(:employee, user: new_user, first_name: "Brett", last_name: "Cooper", ssn: "084-35-9823", date_hired: 2.weeks.ago.to_date, date_terminated: 3.weeks.ago.to_date)
      deny fired_before_hired.valid?
    end

  end


end
