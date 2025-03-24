require 'test_helper'

class OrderScopeTest < ActiveSupport::TestCase
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

    should "have a working scope called paid" do
      assert_equal [5.25, 5.50, 16.50], Order.paid.all.map(&:grand_total).sort
    end

    should "have a working scope called chronological" do
      # would all be today given new before_create callback, so change date on one order
      @alexe_o3.date = 5.days.ago.to_date
      @alexe_o3.save # moving this large order from the middle to the back
      assert_equal [5.5, 5.5, 16.5, 11.0, 5.25, 5.25, 22.5], Order.chronological.all.map(&:grand_total)
    end

    should "have a working scope called for_customer" do
      assert_equal [5.25, 5.25, 22.50], Order.for_customer(@alexe).all.map(&:grand_total).sort
    end

    should "have a working scope called for_period" do
      # reset dates so not all today
      (1..5).each do |i| 
        o = Order.find(i)
        o.date = i.days.ago.to_date
        o.save
      end
  
      # test for a range in the middle (not first or last)
      assert_equal [3.days.ago.to_date, 2.days.ago.to_date, 1.day.ago.to_date], Order.for_period(3.days.ago, 1.day.ago).map(&:date)
      # confirm first and last records with grand totals
      assert_equal 22.5, Order.for_period(3.days.ago.to_date, 1.day.ago.to_date).first.grand_total
      assert_equal 5.25, Order.for_period(3.days.ago.to_date, 1.day.ago.to_date).last.grand_total
    end

    should "have a working scope called open_orders" do
      assert_equal [5.5, 11.0, 16.5, 22.5], Order.open_orders.all.map(&:grand_total).sort
    end

    should "have a working scope called shipped_orders" do
      assert_equal [5.25, 5.25, 5.5], Order.shipped_orders.all.map(&:grand_total).sort
    end

  end
end


