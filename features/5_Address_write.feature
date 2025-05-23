Feature: Adding addresses
  As as a customer
  I want to be able to add new addresses when I order
  So I can send RDP items to family and friends

  Background:
    Given a logged in customer

  Scenario: Add items to the cart
    When I go to the items page
    And I click on the link "Chocolate Zucchini Muffins"
    Then I should see "View Cart"
    And I should see "Current Price: $9.25"
    When I click on the link "Add to Cart"
    Then I should see "Chocolate Zucchini Muffins was added to cart."
    And I should see "View Cart(1)"
    When I click on the link "View Cart(1)"
    Then I should see "Your Cart"
    When I click on the link "Checkout"
    And I click on the link "Add a new address"
    Then I should see "New Address"
    And I fill in "address_recipient" with "Chloe Deng"
    And I fill in "address_street_1" with "250 East Ohio Street"
    And I fill in "address_street_2" with "Apt 221"
    And I fill in "address_city" with "Pittsburgh"
    And I select "Pennsylvania" from "address_state"
    And I fill in "address_zip" with "15212"
    And I press "Create Address"
    Then I should see "Address was added for customer Alex Egan."