require "test_helper"

class CustomersControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as(:manager)
    @user_customer = FactoryBot.create(:user, role: 'customer')
    @customer = FactoryBot.create(:customer, user: @user_customer)
  end

  test "should get index" do
    get customers_path
    assert_response :success
    assert_not_nil assigns(:active_customers)
    assert_not_nil assigns(:inactive_customers)
  end

  test "should get new as manager" do
    get new_customer_path
    assert_response :success
  end

  test "should get new as guest" do
    logout_now
    get new_customer_path
    assert_response :success
  end

  test "should create customer if valid" do
    assert_difference('Customer.count') do
      post customers_path, params: { customer: { active: true, first_name: "Ted", last_name: "Gruberman", email: "tgrub@example.com", phone: "412-268-2323", user_attributes: {username: "ted", password: "secret", password_confirmation: "secret"} } }
    end
    assert_equal "Welcome to Roi du Pain -- We hope you enjoy shopping with us.", flash[:notice]
    assert_redirected_to customer_path(Customer.last)
  end

  test "should not create customer if invalid" do
    post customers_path, params: { customer: { active: true, first_name: nil, last_name: "Gruberman", email: "tgrub@example.com", phone: "412-268-2323", user_attributes: {username: "ted", password: "secret", password_confirmation: "secret"} } }
    assert_template :new
  end

  test "should not create customer without valid user" do
    post customers_path, params: { customer: { active: true, first_name: "Ted", last_name: "Gruberman", email: "tgrub@example.com", phone: "412-268-2323" } }
    assert_template :new
  end

  test "should create a customer as a guest (regardless of role params)" do
    logout_now
    assert_difference('Customer.count') do
      post customers_path, params: { customer: { active: true, first_name: "Ted", last_name: "Gruberman", email: "tgrub@example.com", phone: "412-268-2323", user_attributes: {username: "ted", password: "secret", password_confirmation: "secret", role: "manager"} } }
    end
    assert_not_nil session[:user_id]
    assert_not_nil session[:cart]
    # customer should be created with role 'customer' regardless of what is passed in
    assert Customer.last.user.customer_role?
  end

  test "should show customer" do
    get customer_path(@customer)
    assert_response :success
    assert_not_nil assigns(:customer)
    assert_not_nil assigns(:previous_orders)
    assert_not_nil assigns(:addresses)
  end

  test "should get edit" do
    get edit_customer_path(@customer)
    assert_response :success
  end

  test "should update customer if valid" do
    patch customer_path(@customer), params: { customer: { active: true, first_name: "Eddie", last_name: @customer.last_name, email: @customer.email, phone: @customer.phone } }
    assert_equal "Eddie Gruberman was revised in the system.", flash[:notice]
    assert_redirected_to customer_path(@customer)
  end

  test "should not update customer if invalid" do
    patch customer_path(@customer), params: { customer: { active: true, first_name: nil, last_name: @customer.last_name, email: @customer.email, phone: @customer.phone } }
    assert_template :edit
  end

  test "should not have route for destroy nor should controller respond to destroy" do
    assert_raise ActionController::UrlGenerationError do get url_for(controller: "customers", action: "destroy", id: "#{@customer.id}") end
    deny CustomersController.new.respond_to?(:destroy)
  end
end

