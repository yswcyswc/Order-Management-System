require 'test_helper'

class ItemScopeTest < ActiveSupport::TestCase
  context "Within context" do
    setup do 
      create_muffins
    end

    should "show that there are three items in in alphabetical order" do
      assert_equal ["Apple Carrot Muffins", "Blueberry Muffins", "Chocolate Zucchini Muffins"], Item.alphabetical.all.map(&:name)
    end

    should "show that there are two active items and one inactive item" do
      assert_equal ["Blueberry Muffins", "Chocolate Zucchini Muffins"], Item.active.all.map(&:name).sort
      assert_equal ["Apple Carrot Muffins"], Item.inactive.all.map(&:name).sort
    end

    should "show that there is a scope for all muffins" do
      create_breads  # to make sure we only get muffins
      assert_equal ["Apple Carrot Muffins", "Blueberry Muffins", "Chocolate Zucchini Muffins"], Item.muffins.all.map(&:name).sort
    end

    should "show that there is a scope for all breads" do
      create_breads # because we already have muffins
      assert_equal ["Apple Cherry Bread", "Challah Bread", "Cinnamon Swirl Bread", "Honey Wheat Bread", "Sourdough Bread"], Item.breads.all.map(&:name).sort
    end

    should "show that there is a scope for all pastries" do
      create_pastries # because we already have muffins
      assert_equal ["Crossiants"], Item.pastries.all.map(&:name).sort
    end
  end
end
