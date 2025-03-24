require 'test_helper'

class OrderPaymentTest < ActiveSupport::TestCase
  context "Within context" do
    setup do 
      create_breads
      create_bread_prices
      create_customer_users
      create_customers
      create_addresses
      create_valid_cards
      create_orders
      create_order_items
    end

    should "have accessor methods for credit card data" do
      assert Order.new.respond_to? :credit_card_number
      assert Order.new.respond_to?(:credit_card_number=)
      assert Order.new.respond_to? :expiration_year
      assert Order.new.respond_to?(:expiration_year=)
      assert Order.new.respond_to? :expiration_month
      assert Order.new.respond_to?(:expiration_month=)
    end

    should "have a pay method which generates a receipt string" do
      assert @melanie_o2
      @melanie_o2.credit_card_number = @visa16.number
      @melanie_o2.expiration_year = @visa16.expiration_year
      @melanie_o2.expiration_month = @visa16.expiration_month
      assert_nil @melanie_o2.payment_receipt
      @melanie_o2.pay
      @melanie_o2.reload
      assert_not_nil @melanie_o2.payment_receipt
    end

    should "not be able to pay twice for same order" do
      assert_nil @melanie_o2.payment_receipt
      @melanie_o2.credit_card_number = @visa16.number
      @melanie_o2.expiration_year = @visa16.expiration_year
      @melanie_o2.expiration_month = @visa16.expiration_month
      first_pay = @melanie_o2.pay
      assert_not_nil @melanie_o2.payment_receipt
      second_pay = @melanie_o2.pay
      assert_not_equal first_pay, second_pay
    end

    should "have a properly formatted payment receipt" do
      # credit card info
      @alexe_o2.credit_card_number = @mc54.number
      @alexe_o2.expiration_year = @mc54.expiration_year
      @alexe_o2.expiration_month = @mc54.expiration_month
      @alexe_o3.credit_card_number = @mc54.number
      @alexe_o3.expiration_year = @mc54.expiration_year
      @alexe_o3.expiration_month = @mc54.expiration_month

      # test with a paid order to a non-billing address (i.e., zip code is not the order address zip)
      assert_nil @alexe_o2.payment_receipt
      @alexe_o2.pay
      assert_equal "order: #{@alexe_o2.id}; amount_paid: #{@alexe_o2.grand_total}; received: #{@alexe_o2.date}; card: #{@alexe_o2.credit_card_type} ****#{@alexe_o2.credit_card_number[-4..-1]}; billing zip: #{@alexe.billing_address.zip}", Base64.decode64(@alexe_o2.payment_receipt), "#{Base64.decode64(@alexe_o2.payment_receipt)}"
      # verify with payment an order to a billing address is fine too
      assert_nil @alexe_o3.payment_receipt
      @alexe_o3.pay
      assert_equal "order: #{@alexe_o3.id}; amount_paid: #{@alexe_o3.grand_total}; received: #{@alexe_o3.date}; card: #{@alexe_o3.credit_card_type} ****#{@alexe_o3.credit_card_number[-4..-1]}; billing zip: #{@alexe.billing_address.zip}", Base64.decode64(@alexe_o3.payment_receipt), "#{Base64.decode64(@alexe_o3.payment_receipt)}"
    end

    should "identify different types of credit card by their pattern" do
      # lengths are all correct for these tests, but prefixes are not
      assert @melanie_o2.valid?
      numbers = {4123456789012=>"VISA", 4123456789012345=>"VISA", 5123456789012345=>"MC", 5412345678901234=>"MC", 6512345678901234=>"DISC", 6011123456789012=>"DISC", 30012345678901=>"DCCB", 30312345678901=>"DCCB", 341234567890123=>"AMEX", 371234567890123=>"AMEX",7123456789012=>"N/A",30612345678901=>"N/A",351234567890123=>"N/A",5612345678901234=>"N/A",6612345678901234=>"N/A"}
      numbers.each do |num, name|
        @melanie_o2.credit_card_number = num
        assert_equal name, @melanie_o2.credit_card_type, "#{@melanie_o2.credit_card_type} :: #{@melanie_o2.credit_card_number}"
      end
    end

    should "detect different types of valid and invalid credit card numbers" do
      # similar to previous, but testing the actual validation method exists
      @melanie_o2.credit_card_number = nil
      deny @melanie_o2.valid?
      valid_numbers = %w[4123456789012 4123456789012345 5123456789012345 5412345678901234 6512345678901234 6011123456789012 30012345678901 30312345678901 341234567890123 371234567890123]
      valid_numbers.each do |num|
        @melanie_o2.credit_card_number = num
        assert @melanie_o2.valid?, "#{@melanie_o2.credit_card_number}"
      end
      invalid_numbers = %w[7123456789012 30612345678901 351234567890123 5612345678901234 6612345678901234]
      invalid_numbers.each do |num|
        @melanie_o2.credit_card_number = num
        deny @melanie_o2.valid?, "#{@melanie_o2.credit_card_number}"
      end
    end  

    should "detect different types of too-short credit card numbers" do
      # prefixes are all correct for these tests, but length is too short for card type
      assert @melanie_o2.valid?
      short_numbers = %w[412345678901 412345678901234 512345678901234 541234567890123 651234567890123 601112345678901 3001234567890 3031234567890 34123456789012 37123456789012]
      short_numbers.each do |num|
        @melanie_o2.credit_card_number = num
        deny @melanie_o2.valid?, "#{@melanie_o2.credit_card_number}"
      end
    end 

    should "detect different types of too-long credit card numbers" do
      # prefixes are all correct for these tests, but length is too long for card type
      assert @melanie_o2.valid?
      long_numbers = %w[41234567890121 41234567890123451 51234567890123451 54123456789012341 65123456789012341 60111234567890121 300123456789011 303123456789011 3412345678901231 3712345678901231]
      long_numbers.each do |num|
        @melanie_o2.credit_card_number = num
        deny @melanie_o2.valid?, "#{@melanie_o2.credit_card_number}"
      end
    end

    should "detect valid and invalid expiration dates" do
      assert @melanie_o2.valid?
      @melanie_o2.expiration_year = 1.year.ago.year
      deny @melanie_o2.valid?
      @melanie_o2.expiration_year = Date.today.year
      @melanie_o2.expiration_month = Date.today.month
      assert @melanie_o2.valid?
      @melanie_o2.expiration_year = Date.today.year
      @melanie_o2.expiration_month = Date.today.month - 1
      deny @melanie_o2.valid?
      @melanie_o2.expiration_year = Date.today.year
      @melanie_o2.expiration_month = Date.today.month + 1
      assert @melanie_o2.valid?
    end

  end
end


