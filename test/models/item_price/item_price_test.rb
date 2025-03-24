require 'test_helper'

class ItemPriceTest < ActiveSupport::TestCase
  # test relationships
  should belong_to(:item)

  # test validations with matchers
  should validate_presence_of(:item_id)
  should validate_presence_of(:price)
  should validate_numericality_of(:price).is_greater_than_or_equal_to(0)

  context "Within context" do
    setup do 
      create_muffins
      create_muffin_prices
    end

    should "verify that the item is active in the system" do
      deny @apple_carrot.active
      @bad_price = FactoryBot.build(:item_price, item: @apple_carrot, price: 10.95)
      deny @bad_price.valid?
    end 
  end
end

