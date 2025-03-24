Feature: Order listing
  As as a customer
  I want to be able to see information on orders
  So I can know the order history and process pending orders

  Scenario: Order listings for customer
    Given a logged in customer
    When I go to the orders page
    Then I should not see "Pending"
    And I should not see "Past"
    And I should see "All Orders"
    And I should see "Date"
    And I should see "Recipient"
    And I should see "Item Count"
    And I should see "Weight"
    And I should see "Cost"
    And I should see "02/17/25"
    And I should see "Jeff Egan"
    And I should see "1"
    And I should see "1.0"
    And I should see "$7.25"
    And I should see "02/11/25"
    And I should see "Alex Egan"
    And I should see "$40.50"
    And I should not see "Melanie Freeman"
    And I should not see "Anthony Corletti"
    And I should not see "Ryan Flood"
    And I should not see "5000 Forbes"

  Scenario: Order details for customer
    Given a logged in customer
    When I go to the orders page
    And I click on the link "02/17/25"
    And I should see "Order Details"
    And I should see "Date: February 17, 2025"
    And I should see "Recipient"
    And I should see "Recipient: Jeff Egan"
    And I should see "Items:"
    And I should see "Honey Wheat Bread (1)"
    And I should see "Total Cost: $7.25"
    And I should see "Other Orders"
    And I should not see "02/17/25"
    And I should see "Date"
    And I should see "02/14/25"
    And I should see "02/11/25"
    And I should see "Amount"
    And I should see "$40.50"
    When I click on the link "Jeff Egan"
    Then I should see "Address:"

