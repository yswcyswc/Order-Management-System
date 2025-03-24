require 'test_helper'

class ItemMethodsTest < ActiveSupport::TestCase
  context "Within context" do
    setup do 
      create_muffins
    end

    should "return correct current price" do
      create_muffin_prices
      assert_equal 9.25, @chocolate_zuke.current_price
      assert_equal 8.95, @blueberry.current_price
    end

    should "return correct price for past date" do
      create_muffin_prices
      assert_equal 7.95, @chocolate_zuke.price_on_date(8.months.ago.to_date)
      assert_equal 8.50, @blueberry.price_on_date(4.months.ago.to_date)
    end

    should "show that an item that has been shipped cannot be destroyed" do
      create_breads
      create_bread_prices
      create_customer_users
      create_customers
      create_addresses
      create_orders
      create_order_items
      deny @honey_wheat.order_items.shipped.empty?
      deny @honey_wheat.destroy
      deny @honey_wheat.destroyed?
    end

    should "show that an item that has never shipped can be destroyed" do
      create_breads
      create_bread_prices
      create_customer_users
      create_customers
      create_addresses
      create_orders
      create_order_items
      @blueberry.destroy
      assert @blueberry.destroyed?
    end

    should "show that a destroyed item is not part of unshipped, unpaid orders" do
      create_breads
      create_bread_prices
      create_customer_users
      create_customers
      create_addresses
      create_orders
      create_order_items
      assert_equal 1, @ryan_o1.order_items.count
      extra_item = FactoryBot.create(:order_item, order: @ryan_o1, item: @blueberry, quantity: 1)
      assert_equal 2, @ryan_o1.order_items.count
      @blueberry.destroy
      assert @blueberry.destroyed?
      @ryan_o1.reload
      # the blueberry muffins should be deleted from Ryan's order items
      assert_equal 1, @ryan_o1.order_items.count
    end

    should "not make inactive because of an improper edit" do
      assert @blueberry.active
      @blueberry.name = nil
      deny @blueberry.valid?
      # try to save the invalid record; see that it is not saved (rollback)
      deny @blueberry.save
      # verify that the rollback did not make the address inactive
      assert @blueberry.active
    end

    should "have make_active and make_inactive methods" do
      assert @blueberry.active
      @blueberry.make_inactive
      @blueberry.reload
      deny @blueberry.active
      @blueberry.make_active
      @blueberry.reload
      assert @blueberry.active
    end

    should "have a method to find popular items on a given date" do
      create_breads
      create_bread_prices
      create_customer_users
      create_customers
      create_addresses
      create_orders
      create_order_items
      assert_equal 0, Item.popular_items_on(1.day.ago.to_date).count
      assert_equal ({@honey_wheat=>5, @challah=>4, @sourdough=>3, @cinnamon_swirl=>2}), Item.popular_items_on(Date.current)
    end

  end
end
