require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  context "Within context" do
    setup do 
      create_customer_users
      create_customers
      create_addresses
    end

    # testing some callbacks and other methods
    should "unset old billing address when new one set" do
      # confirm the current billing address
      assert_equal @alexe_a1, @alexe.billing_address
      refute_equal @alexe_a2, @alexe.billing_address
      # change the billing address to address 2
      @alexe_a2.is_billing = true
      @alexe_a2.save
      # confirm that address 1 no longer billing
      refute_equal @alexe_a1, @alexe.billing_address
      # confirm that address 2 is now billing
      assert_equal @alexe_a2, @alexe.billing_address
    end

    should "allow an existing address to be edited" do
      @alexe_a1.street_1 = "5005 Forbes Avenue"
      assert @alexe_a1.valid?
    end

    should "show that a shipping address that has never used can be destroyed" do
      new_address = FactoryBot.create(:address, customer: @alexe, recipient: "James Egan", street_1: "2000 Forbes Ave", active: true, is_billing: false)
      assert_equal "James Egan", new_address.recipient
      new_address.destroy
      assert new_address.destroyed?
    end

    should "make sure an billing address stays active even if attempting to destroy" do
      create_orders
      assert @alexe_a1.active
      assert @alexe_a1.is_billing
      deny @alexe_a1.orders.empty?
      deny @alexe_a1.destroy
      @alexe_a1.reload
      # verify the address is still active
      assert @alexe_a1.active
      # ... and that the orders are still there
      deny @alexe_a1.orders.empty?
    end

    should "make sure an billing address stays active even if attempting to make inactive" do
      assert @alexe_a1.active
      assert @alexe_a1.is_billing
      @alexe_a1.active = false
      deny @alexe_a1.valid?
    end

    should "not allow an active billing address to be destroyed even if never associated with an order" do
      create_orders
      new_user = FactoryBot.create(:user, username: "jessica", role: "customer")
      new_customer = FactoryBot.create(:customer, user: new_user, first_name: "Jessica", last_name: "Rabbit")
      new_address = FactoryBot.create(:address, customer: new_customer, recipient: "Jessica Rabbit", street_1: "6000 Forbes Ave", active: true, is_billing: true)
      deny Order.all.empty?
      assert new_customer.orders.empty?
      assert new_address.is_billing
      deny new_address.destroy
    end

    should "have make_active and make_inactive methods" do
      assert @alexe_a2.active
      @alexe_a2.make_inactive
      @alexe_a2.reload
      deny @alexe_a2.active
      @alexe_a2.make_active
      @alexe_a2.reload
      assert @alexe_a2.active
    end
  end
end