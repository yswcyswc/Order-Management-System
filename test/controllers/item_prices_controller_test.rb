require "test_helper"

class ItemPricesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as(:manager)
    @item = FactoryBot.create(:item)
  end

  test "should get new" do
    get new_item_price_path
    assert_response :success
  end

  test "should create item price if valid" do
    assert_difference('ItemPrice.count') do
      post item_prices_path, params: { item_price: { item_id: @item.id, price: 4.95 } }
    end
    assert_equal "New price of Honey Wheat Bread is $4.95.", flash[:notice]
    assert_redirected_to item_path(Item.last)
  end

  test "should not create item price if invalid" do
    post item_prices_path, params: { item_price: { item_id: @item.id, price: nil } }
    assert_template :new
  end

  test "should not permit date parameter" do
    post item_prices_path, params: { item_price: { item_id: @item.id, price: 4.95, date: Date.yesterday } }
    controller_params = @controller.send(:item_price_params)
    assert_not controller_params.key?(:date)
  end

  test "should not have generic routes or actions" do
    @item_price = FactoryBot.create(:item_price, item: @item, price: 4.95)
    assert_raise ActionController::UrlGenerationError do get url_for(controller: "item_prices", action: "index") end
    deny ItemPricesController.new.respond_to?(:index)
    assert_raise ActionController::UrlGenerationError do get url_for(controller: "item_prices", action: "show", id: "#{@item_price.id}") end
    deny ItemPricesController.new.respond_to?(:show)
    assert_raise ActionController::UrlGenerationError do get url_for(controller: "item_prices", action: "edit", id: "#{@item_price.id}") end
    deny ItemPricesController.new.respond_to?(:edit)
    assert_raise ActionController::UrlGenerationError do get url_for(controller: "item_prices", action: "update", id: "#{@item_price.id}") end
    deny ItemPricesController.new.respond_to?(:update)
    assert_raise ActionController::UrlGenerationError do get url_for(controller: "item_prices", action: "destroy", id: "#{@item_price.id}") end
    deny ItemPricesController.new.respond_to?(:destroy)
  end


end

