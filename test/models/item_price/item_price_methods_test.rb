require 'test_helper'

class ItemPriceMethodsTest < ActiveSupport::TestCase
  context "Within context" do
    setup do 
      create_muffins
      create_muffin_prices
    end

    should "verify that the old price end_date set to today" do
      assert_nil @bl3.end_date
      @change_price = FactoryBot.create(:item_price, item: @blueberry, price: 10.95)
      @bl3.reload
      assert_equal Date.today, @bl3.end_date
    end

    should "verify that the new price start_date set to tomorrow" do
      # assert_nil @bl3.end_date
      @change_price = FactoryBot.create(:item_price, item: @blueberry, price: 10.95)
      # @bl3.reload
      assert_equal Date.tomorrow, @change_price.start_date
    end

    should "correctly assess that an item_price is not destroyable" do
      deny @bl3.destroy
    end

  end
end