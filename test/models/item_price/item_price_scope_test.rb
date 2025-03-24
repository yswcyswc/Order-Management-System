require 'test_helper'

class ItemPriceScopeTest < ActiveSupport::TestCase
  context "Within context" do
    setup do 
      create_muffins
      create_muffin_prices
    end

    should "have a working scope called current" do
      assert_equal [8.95, 9.25], ItemPrice.current.all.map(&:price).sort
    end

    should "have a working scope called chronological" do
      assert_equal [7.95, 7.95, 8.50, 8.50, 9.25, 8.95], ItemPrice.chronological.all.map(&:price)
    end

    should "have a working scope called reverse_chronological" do
      assert_equal [8.95, 9.25, 8.50, 8.50, 7.95, 7.95], ItemPrice.reverse_chronological.all.map(&:price)
    end

    should "have a working scope called for_date" do
      assert_equal [8.50, 8.50], ItemPrice.for_date(4.months.ago.to_date).all.map(&:price)
      assert_equal [7.95, 7.95], ItemPrice.for_date(7.months.ago.to_date).all.map(&:price)
    end

    should "have a working scope called for_item" do
      assert_equal [8.95, 8.50, 7.95], ItemPrice.for_item(@blueberry.id).all.map(&:price).sort.reverse
      assert_equal [9.25, 8.50, 7.95], ItemPrice.for_item(@chocolate_zuke.id).all.map(&:price).sort.reverse
    end

  end
end