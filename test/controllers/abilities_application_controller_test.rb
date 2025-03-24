require 'test_helper'

class AbilitiesApplicationControllerTest < ActionDispatch::IntegrationTest

  # A few tests to make sure abilities were properly applied at the controller
  # level and the exception is properly handled
  setup do
    create_items
    create_employee_users
    create_employees 
    create_customer_users
    create_customers 
    create_addresses
    create_orders
    get logout_path
  end

  test "a customer can see their orders" do
    login_user(@u_alexe)
    get orders_path
    assert_response :success
    get order_path(@alexe_o1)
    assert_response :success
  end

  test "a customer cannot see orders that are not their own" do
    login_user(@u_alexe)
    get orders_path
    assert_response :success
    get order_path(@melanie_o1)
    assert_equal "You are not authorized to take this action.", flash[:error]
    assert_redirected_to home_path
  end

  # test "a shipper can see addresses" do
  #   login_as(:shipper)
  #   get addresses_path
  #   assert_response :success
  # end

  # test "an officer can read his own information" do
  #   login_officer(@jblake)
  #   get officer_path(@jblake)
  #   assert_response :success
  # end

  # test "an officer cannot see other officers" do
  #   login_officer(@jblake)
  #   get officer_path(@jgordon)
  #   assert_equal "You are not authorized to take this action.", flash[:error]
  #   assert_redirected_to home_path
  # end

  # test "an officer cannot update other officers" do
  #   login_officer(@jblake)
  #   get edit_officer_path(@jazeveda)
  #   assert_equal "You are not authorized to take this action.", flash[:error]
  #   assert_redirected_to home_path
  # end

  # test "an officer cannot create an assignment" do
  #   login_officer(@jblake)
  #   get new_assignment_path
  #   assert_equal "You are not authorized to take this action.", flash[:error]
  #   assert_redirected_to home_path
  # end

  # test "an officer cannot terminate an assignment" do
  #   login_officer(@jblake)
  #   patch terminate_assignment_path(@lacey_jblake)
  #   assert_equal "You are not authorized to take this action.", flash[:error]
  #   assert_redirected_to home_path
  # end

end