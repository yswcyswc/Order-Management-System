require './test/contexts'
include Contexts

Given /^an initial setup$/ do
  # context
  create_customer_users
  create_employee_users
  create_customers
  create_addresses
  create_employees
  create_items
  create_item_prices
  create_orders
  create_order_items
  create_additional_orders_and_items

  # update order dates, costs to fixed values
  @alexe_o1.update_attribute(:date, Date.new(2025,2,14))
  @alexe_o2.update_attribute(:date, Date.new(2025,2,17))
  @alexe_o3.update_attribute(:date, Date.new(2025,2,11))
  @alexe_o1.update_attribute(:grand_total, 7.25)
  @alexe_o2.update_attribute(:grand_total, 7.25)
  @alexe_o3.update_attribute(:grand_total, 40.50)
  # update alexe's email and created_at to 2020 (i.e., a customer for 5 years now)
  @alexe.update_attribute(:email, "alex.egan@example.com")
  @alexe.update_attribute(:phone, "4122688211")
  @alexe.update_attribute(:created_at, Date.new(2020,2,17))
end

Given /^no setup yet$/ do
  # assumes initial setup already run as background
  destroy_orders
  destroy_items
  destroy_addresses
  destroy_customers
end

Given /^a logged in manager$/ do
  step "an initial setup"
  visit login_url
  fill_in "Username", :with => "mark"
  fill_in "Password", :with => "secret"
  click_button "Log In"
end

Given /^a logged in customer$/ do
  step "an initial setup"
  visit login_url
  fill_in "Username", :with => "alexe"
  fill_in "Password", :with => "secret"
  click_button "Log In"
end
