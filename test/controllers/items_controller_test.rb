require "test_helper"

class ItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as(:manager)
    @item = FactoryBot.create(:item, name: "Cardinal Bread")
  end

  test "should get index for managers" do
    get items_path
    assert_response :success
    assert_not_nil assigns(:breads)
    assert_not_nil assigns(:muffins)
    assert_not_nil assigns(:pastries)
    assert_not_nil assigns(:inactive_items)
  end

  test "should get index for customers" do
    logout_now
    login_as(:customer)
    get items_path
    assert_response :success
    assert_not_nil assigns(:breads)
    assert_not_nil assigns(:muffins)
    assert_not_nil assigns(:pastries)
    assert_nil assigns(:inactive_items)
  end

  test "should get new" do
    get new_item_path
    assert_response :success
  end

  test "should create item if valid" do
    assert_difference('Item.count') do
      post items_path, params: { item: { active: true, name: "Monkey Bread", category: "breads", units_per_item: 4, weight: 1.4 } }
    end
    assert_equal "Monkey Bread was added to the system.", flash[:notice]
    assert_redirected_to item_path(Item.last)
  end

  test "should not create item if invalid" do
    post items_path, params: { item: { active: true, name: nil, category: "breads", units_per_item: 4, weight: 1.4 } }
    assert_template :new
  end

  test "should show item for manager" do
    get item_path(@item)
    assert_response :success
    assert_not_nil assigns(:item)
    assert_not_nil assigns(:similar_items)
    assert_not_nil assigns(:price_history)
  end

  test "should show item for customer" do
    logout_now
    login_as(:customer)
    get item_path(@item)
    assert_response :success
    assert_not_nil assigns(:similar_items)
    assert_nil assigns(:price_history)
  end

  test "should get edit" do
    get edit_item_path(@item)
    assert_response :success
  end

  test "should update item if valid" do
    patch item_path(@item), params: { item: { active: true, name: "New Bread", category: @item.category, units_per_item: @item.units_per_item, weight: @item.weight } }
    assert_equal "New Bread was revised in the system.", flash[:notice]
    assert_redirected_to item_path(@item)
  end

  test "should not update item if invalid" do
    patch item_path(@item), params: { item: { active: true, name: nil, category: @item.category, units_per_item: @item.units_per_item, weight: @item.weight } }
    assert_template :edit
  end

  test "should destroy item when appropriate" do
    assert_difference('Item.count', -1) do
      delete item_path(@item)
    end
    assert_equal "Cardinal Bread was removed from the system.", flash[:notice]
    assert_redirected_to items_path
  end

  test "should not destroy item when inappropriate" do
    # Create a shipped order with this item
    @user_customer = FactoryBot.create(:user, role: 'customer')
    @customer = FactoryBot.create(:customer, user: @user_customer)
    @address = FactoryBot.create(:address, customer: @customer, recipient: 'Chloe Deng', is_billing: true)
    @order = FactoryBot.create(:order, address: @address, customer: @customer)
    @order_item = FactoryBot.create(:order_item, order: @order, item: @item, shipped_on: Date.current)
    @item.reload
    assert_difference('Item.count', 0) do
      delete item_path(@item)
    end
    assert_equal "Cardinal Bread has been used for prior orders and cannot be deleted.", flash[:error]
    assert_redirected_to item_path(@item)
  end
  
end