require 'test_helper'

class OrderShippingTest < ActiveSupport::TestCase
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

    should "correctly calculate total weight of the order" do
      assert_equal 1.0, @alexe_o1.total_weight
      assert_equal 6.7, @alexe_o3.total_weight
    end

    should "correctly assess shipping costs of the order" do
      assert_equal 2, @alexe_o1.shipping_costs
      assert_equal 2.25, @alexe_o3.shipping_costs, "WEIGHT: #{@alexe_o3.total_weight}; #{Shipping.calculate_shipping_costs(@alexe_o3.total_weight)}"
    end

    should "correctly find the unshipped items in an order" do
      assert_equal 2, @alexe_o3.unshipped_items.count
      assert_equal [@alexe_o3_1, @alexe_o3_2], @alexe_o3.unshipped_items
      # now create a partially shipped order and verify method works
      @alexe_o3_1.shipped_on = Date.current
      @alexe_o3_1.save
      @alexe_o3.reload
      assert_equal [@alexe_o3_2], @alexe_o3.unshipped_items
    end

    should "not return an array but rather an ActiveRecord::Relation for not_shipped method" do
      deny Order.not_shipped.kind_of?(Array)
      assert Order.not_shipped.kind_of?(ActiveRecord::Relation)
    end

    should "correctly return a list of unshipped orders" do
      assert_equal 4, Order.not_shipped.count
      assert_equal ["Alex Egan", "Anthony Corletti", "Melanie Freeman", "Ryan Flood"], Order.not_shipped.map{|o| o.address.recipient}.sort
    end

    should "correctly return a count of the items in an order" do
      assert_equal 7, @alexe_o3.item_count
    end

  end
end


