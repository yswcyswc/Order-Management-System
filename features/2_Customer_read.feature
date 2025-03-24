Feature: Manage customers
  As a manager
  I want to be able to manage customer information
  So customers have accounts to use for making orders

  Background:
    # Given an initial setup
    Given a logged in manager

  # READ METHODS
  Scenario: View all customers
    When I go to the customers page
    Then I should see "Active Customers"
    And I should see "Name"
    And I should see "Phone"
    And I should see "Email"
    And I should see "Corletti, Anthony"
    And I should see "Egan, Alex"
    And I should see "Flood, Ryan"
    And I should see "Freeman, Melanie"
    And I should see "alex.egan@example.com"
    And I should see "412-268-2323"
    And I should see "Inactive Customers"
    And I should not see "true"
    And I should not see "True"
    And I should not see "ID"
    And I should not see "_id"
    And I should not see "Created"
    And I should not see "created"

  Scenario: View customer details
    When I go to Alex Egan details page
    Then I should see "A Roi du Pain customer since 2020"
    And I should see "Alex Egan"
    And I should see "Phone"
    And I should see "412-268-8211"
    And I should see "Email"
    And I should see "alex.egan@example.com"
    And I should see "Addresses on file"
    And I should see "Jeff Egan"
    And I should see "4000 Forbes Ave"
    And I should see "Pittsburgh, PA 15212"
    And I should see "5000 Forbes Avenue"
    And I should see "Order History"
    And I should see "Date"
    And I should see "Amount"
    And I should see "02/17/25"
    And I should see "$7.25"
    And I should see "02/14/25"
    And I should see "$7.25"
    And I should see "02/11/25"
    And I should see "$40.50"
    And I should not see "$5.25"
    And I should see "Addresses on file"
    And I should see "Jeff Egan"
    And I should see "4000 Forbes Ave"
    And I should see "Pittsburgh, PA 15212"
    And I should not see "true"
    And I should not see "True"
    And I should not see "ID"
    And I should not see "_id"
    And I should not see "Created"
    And I should not see "created"

  Scenario: The customer name is a link to details
    When I go to the customers page
    And I click on the link "Egan, Alex"
    And I should see "Alex Egan"
    And I should see "Phone"
    And I should see "412-268-8211"
    And I should see "Order History"
    And I should see "Date"
    And I should see "Amount"
    And I should see "$40.50"
    And I should see "02/11/25"

  Scenario: The order date in #show is a link to order details
    When I go to Alex Egan details page
    And I click on the link "02/14/25"
    Then I should see "Date: February 14, 2025"
    And I should see "Customer: Alex Egan"
    And I should see "Recipient: Jeff Egan"
    And I should see "Total Cost: $7.25"

