require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  require 'base64'

  # test relationships
  should have_many(:order_items)
  should have_many(:items).through(:order_items)
  should belong_to(:customer)
  should belong_to(:address)

  # test simple validations with matchers
  should validate_numericality_of(:grand_total).is_greater_than_or_equal_to(0)
  # should allow_value(Date.today).for(:date)
  # should allow_value(1.day.ago.to_date).for(:date)
  # should allow_value(1.day.from_now.to_date).for(:date)
  # should_not allow_value("bad").for(:date)
  # should_not allow_value(2).for(:date)
  # should_not allow_value(3.14159).for(:date)
 
   context "Within context" do
    setup do 
      create_breads
      create_bread_prices
      create_customer_users
      create_customers
      create_addresses
      create_orders
      create_order_items
    end

    should "verify that the customer is active in the system" do
      # inactive customer
      @bad_order = FactoryBot.build(:order, customer: @sherry, address: @alexe_a2, grand_total: 5.25, payment_receipt: "dcmjgwwtsd39x6wfc1", date: 5.days.ago.to_date)
      deny @bad_order.valid?
      # non-existent customer
      ghost = FactoryBot.build(:customer, first_name: "Ghost")
      non_customer_order = FactoryBot.build(:order, customer: ghost, address: @alexe_a2)
      deny non_customer_order.valid?
    end 

    should "verify that the address is active in the system" do
      # inactive address
      @bad_order = FactoryBot.build(:order, customer: @alexe, address: @alexe_a3, grand_total: 5.25, payment_receipt: "dcmjgwwtsd39x6wfc1", date: 5.days.ago.to_date)
      deny @bad_order.valid?
      # non-existent address
      ghost = FactoryBot.build(:address, customer: @alexe, recipient: "Ghost")
      non_address_order = FactoryBot.build(:order, customer: @alexe, address: ghost)
      deny non_address_order.valid?
    end

    should "correctly assess if an order can be edited" do
      deny @melanie_o1.is_editable?
      assert @melanie_o2.is_editable?
    end

    should "correctly destroy an order that is unshipped" do
      order_id = @ryan_o1.id
      assert_not_nil OrderItem.find_by_order_id(order_id)
      @ryan_o1.destroy
      assert @ryan_o1.destroyed?
      assert_nil OrderItem.find_by_order_id(order_id)
    end

    should "not destroy an order that has already shipped" do
      # verify that this was a shipped order
      deny @alexe_o1.order_items.shipped.empty?
      @alexe_o1.destroy
      deny @alexe_o1.destroyed?
      # verify that nothing was deleted from order_items
      deny @alexe_o1.order_items.empty?
    end

    should "set the date to today before creating an order" do
      @new_order = FactoryBot.build(:order, customer: @alexe, address: @alexe_a2, grand_total: 15.25)
      @new_order.date = nil ## manually set to nil to test callback; factory sets to today
      assert_nil @new_order.date  ## sanity check that it happened
      @new_order.save  ## should trigger the callback
      # @new_order.reload  ## ensure the object is reloaded from the database
      assert_equal Date.current, @new_order.date
    end

  end
end


