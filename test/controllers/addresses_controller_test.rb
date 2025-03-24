require "test_helper"

class AddressesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as(:manager)
    @u_customer = FactoryBot.create(:user, username: 'customer', role: 'customer')
    @customer = FactoryBot.create(:customer, user: @u_customer)
    @address = FactoryBot.create(:address, is_billing: true, customer: @customer)
  end

  test "should get index" do
    get addresses_path
    assert_response :success
    assert_not_nil assigns(:active_addresses)
    assert_not_nil assigns(:inactive_addresses)
  end

  test "should get new" do
    get new_address_path
    assert_response :success
  end

  test "should create address" do
    assert_difference('Address.count') do
      post addresses_path, params: { address: { active: true, recipient: 'Chloe Deng', customer_id: @customer.id, street_1: '5000 Forbes Ave', city: 'Pittsburgh', state: 'PA', zip: '15213' } }
    end
    assert_equal "Address was added for customer #{@customer.proper_name}.", flash[:notice]
    assert_redirected_to customer_path(@customer)
  end

  test "should not create an invalid address" do
    post addresses_path, params: { address: { active: true, recipient: nil, customer_id: @customer.id, street_1: '5000 Forbes Ave', city: 'Pittsburgh', state: 'PA', zip: '15213' } }
    assert_template :new
  end

  test "should create address for current_user if no customer specified" do
    logout_now
    login_user(@u_customer)
    assert_difference('Address.count') do
      post addresses_path, params: { address: { active: true, recipient: 'Chloe Deng', customer_id: nil, street_1: '5000 Forbes Ave', city: 'Pittsburgh', state: 'PA', zip: '15213' } }
    end
    assert_equal "Address was added for customer #{@customer.proper_name}.", flash[:notice]
    assert_redirected_to customer_path(@customer)
  end

  test "should show address" do
    get address_path(@address)
    assert_response :success
    assert_not_nil assigns(:other_addresses)
  end

  test "should get edit" do
    get edit_address_path(@address)
    assert_response :success
  end

  test "should update address" do
    patch address_path(@address), params: { address: { active: true, recipient: 'Chloe Deng', customer_id: @customer.id, street_1: @address.street_1, city: @address.city, state: @address.state, zip: @address.zip } }
    assert_redirected_to customer_path(@customer)

    patch address_path(@address), params: { address: { active: true, recipient: nil, customer_id: @customer.id, street_1: @address.street_1, city: @address.city, state: @address.state, zip: @address.zip } }
    assert_template :edit
  end

  test "should destroy address when appropriate" do
    # Create an order with this address that will be destroyed
    @address_2 = FactoryBot.create(:address, customer: @customer, recipient: 'Chloe Deng', is_billing: false)
    assert_difference('Address.count', -1) do
      delete address_path(@address_2)
    end
    assert_equal "Address was removed from the system.", flash[:notice]
    assert_redirected_to customer_path(@customer)
  end

  test "should not destroy address when inappropriate" do
    # Create an order with this address
    @address_2 = FactoryBot.create(:address, customer: @customer, recipient: 'Chloe Deng', is_billing: false)
    @order = FactoryBot.create(:order, address: @address_2, customer: @customer)
    assert_difference('Address.count', 0) do
      delete address_path(@address_2)
    end
    assert_equal "Address has been used for prior orders and cannot be deleted.", flash[:error]
    assert_redirected_to customer_path(@customer)
  end
end
