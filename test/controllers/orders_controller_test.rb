require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as(:manager)
    @item = FactoryBot.create(:item, name: "Cardinal Bread")
    @user_customer = FactoryBot.create(:user, role: 'customer')
    @customer = FactoryBot.create(:customer, user: @user_customer)
    @address = FactoryBot.create(:address, customer: @customer, recipient: 'Chloe Deng', is_billing: true)
    @order = FactoryBot.create(:order, address: @address, customer: @customer)
    @order_item = FactoryBot.create(:order_item, order: @order, item: @item, shipped_on: Date.current)
  end

  test "should get index" do
    get orders_path
    assert_response :success
    assert_not_nil assigns(:all_orders)
  end

  test "should get show" do
    get order_path(@order)
    assert_response :success
    assert_not_nil assigns(:order)
    assert_not_nil assigns(:order_items)
    assert_not_nil assigns(:other_orders)
  end

  test "should get new" do
    get new_order_path
    assert_response :success
    assert_not_nil assigns(:order)
  end

  test "should get edit" do
    get edit_order_path(@order)
    assert_response :success
    assert_not_nil assigns(:order)
  end

  test "should create order if valid and has a cart associated with it" do
    assert_difference('Order.count') do
      session[:cart] = { @item.id.to_s => 1 }
      post orders_path, params: { order: { customer_id: @customer.id, address_id: @address.id, expiration_month: 12, expiration_year: 2027, credit_card_number: 4444111122225555 } }
    end
    assert_equal "Thank you for ordering from Roi du Pain.", flash[:notice]
    assert session[:cart].empty?
    assert_redirected_to order_path(Order.last)
  end

  test "should not create order if invalid" do
    session[:cart] = { @item.id.to_s => 1 }
    post orders_path, params: { order: { customer_id: @customer.id, address_id: nil, grand_total: 14.95, expiration_month: 12, expiration_year: 2027, credit_card_number: 4444111122225555 } }
    assert_template :new
  end

  test "should update order if valid" do
    patch order_path(@order), params: { order: { customer_id: @order.customer.id, address_id: @order.address.id, grand_total: 16.95, expiration_month: 12, expiration_year: 2027, credit_card_number: 4444111122225555 } }
    assert_equal "Order was revised in the system.", flash[:notice]
    assert_redirected_to order_path(@order)
  end

  test "should not update order if invalid" do
    patch order_path(@order), params: { order: { customer_id: @order.customer.id, address_id: @order.address.id, grand_total: -14.95, expiration_month: 12, expiration_year: 2027, credit_card_number: 4444111122225555 } }
    assert_template :edit
  end

  test "should destroy order when appropriate" do
    # Create a new order with no shipped items
    @order_2 = FactoryBot.create(:order, address: @address, customer: @customer)
    assert_difference('Order.count', -1) do
      delete order_path(@order_2)
    end
    assert_equal "Order was removed from the system.", flash[:notice]
    assert_redirected_to orders_path
  end

  test "should not destroy order when inappropriate" do
    assert_difference('Order.count', 0) do
      delete order_path(@order)
    end
    assert_equal "Order cannot be removed from the system because some items have shipped.", flash[:error]
    assert_redirected_to order_path(@order)
  end

  test "should not accept date parameter" do  
    post orders_path, params: { order: { customer_id: @customer.id, address_id: @address.id, grand_total: 14.95, date: Date.yesterday } }
    assert_equal Date.current, Order.last.date
  end

end