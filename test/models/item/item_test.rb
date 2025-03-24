require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  # test relationships
  should have_many(:order_items)
  should have_many(:item_prices)
  should have_many(:orders).through(:order_items)

  # test validations with matchers
  should validate_presence_of(:name)
  should validate_presence_of(:category)
  should validate_presence_of(:units_per_item)
  should validate_presence_of(:weight)
  should validate_uniqueness_of(:name).case_insensitive
  should validate_numericality_of(:units_per_item).only_integer.is_greater_than(0)
  should validate_numericality_of(:weight).is_greater_than(0)

  should allow_value(1).for(:category)
  should allow_value(2).for(:category)
  should allow_value(3).for(:category)
  should allow_value("breads").for(:category)
  should allow_value("muffins").for(:category)
  should allow_value("pastries").for(:category)
  should_not allow_value(nil).for(:category)

  should allow_value(1).for(:units_per_item)
  should allow_value(1).for(:weight)

  should allow_value(10).for(:units_per_item)
  should allow_value(10).for(:weight)
  should allow_value(10.5).for(:weight)

  should_not allow_value(-10).for(:units_per_item)
  should_not allow_value(-10).for(:weight)
  should_not allow_value(10.5).for(:units_per_item)
  should_not allow_value(0).for(:units_per_item)
  should_not allow_value(0).for(:weight)
  
end
