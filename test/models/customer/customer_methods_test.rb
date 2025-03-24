require 'test_helper'

class CustomerMethodsTest < ActiveSupport::TestCase

  context "Within context" do
    setup do 
      create_customer_users
      create_customers
    end

    should "have working name methods" do
      assert_equal "Chen, Sherry", @sherry.name
      assert_equal "Melanie Freeman", @melanie.proper_name
    end

    should "have a billing_address method" do
      create_addresses
      # find the current billing address
      assert_equal @alexe_a1, @alexe.billing_address
      refute_equal @alexe_a2, @alexe.billing_address
    end

    should "strip non-digits from the phone number" do
      assert_equal "4122682323", @anthony.phone
    end

    should "correctly assess that a customer is not destroyable" do
      deny @melanie.destroy
    end

    should "deactivate the user if the customer is made inactive" do
      assert @u_ryan.active
      assert @ryan.active
      @ryan.active = false
      @ryan.save!
      @ryan.reload
      @u_ryan.reload
      deny @u_ryan.active
    end 

    should "have make_active and make_inactive methods" do
      assert @melanie.active
      @melanie.make_inactive
      @melanie.reload
      deny @melanie.active
      @melanie.make_active
      @melanie.reload
      assert @melanie.active
    end
    
  end
end