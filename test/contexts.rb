# require needed files
require './test/sets/users'
require './test/sets/customers'
require './test/sets/employees'
require './test/sets/addresses'
require './test/sets/items'
require './test/sets/item_prices'
require './test/sets/orders'
require './test/sets/order_items'
require './test/sets/abilities'
require './test/sets/credit_cards'


module Contexts
  # explicitly include all sets of contexts used for testing 
  include Contexts::Users
  include Contexts::Customers
  include Contexts::Addresses
  include Contexts::Employees
  include Contexts::Items
  include Contexts::ItemPrices
  include Contexts::CreditCards
  include Contexts::Orders
  include Contexts::OrderItems
  include Contexts::Abilities

  def create_all
    # puts "Building context..."
    create_customer_users
    # puts "Built customer users"
    create_customers
    # puts "Built customers"
    create_addresses
    # puts "Built addresses"
    create_employee_users
    # puts "Built employee users"
    create_employees
    # puts "Built employees"
    create_items
    # puts "Built items"
    create_item_prices
    # puts "Assign prices to items"
    create_orders
    # puts "Built orders"
    create_order_items
    # puts "Added items to orders"
    # puts "Finished basic contexts"
  end

  def destroy_all
    OrderItem.all.each{|x| x.delete}
    Order.all.each{|x| x.delete}
    ItemPrice.all.each{|x| x.delete}
    Item.all.each{|x| x.delete}
    Employee.all.each{|x| x.delete}
    Address.all.each{|x| x.delete}
    Customer.all.each{|x| x.delete}
    User.all.each{|x| x.delete}
  end

  def create_api_test_context
    create_customer_users
    create_customers
    create_addresses
    create_employee_users
    create_employees
    create_items
    create_item_prices
    create_orders
    create_order_items
  end

  def create_cucumber_context
    create_customer_users
    create_customers
    create_addresses
    create_employee_users
    create_employees
    create_items
    create_item_prices
    create_orders
    create_order_items
    create_additional_orders_and_items
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


end