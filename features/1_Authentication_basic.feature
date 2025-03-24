Feature: Authentication
  As a customer
  I want to create and access an account on the system
  so I can use the system as an authenticated user

  Scenario: Login successful
    Given an initial setup
    When I go to the login page
    And I fill in "username" with "alexe"
    And I fill in "password" with "secret"
    And I press "Log In"
    Then I should see "Logged in!"

  Scenario: Login failed
    Given an initial setup
    When I go to the login page
    And I fill in "username" with "alexe"
    And I fill in "password" with "notsecret"
    And I press "Log In"
    Then I should see "Username and/or password is invalid"

  Scenario: Logout
    Given a logged in customer
    When I go to the home page
    And I click on the link "Logout"
    Then I should see "Logged out!"

  Scenario: Navigation exists to link resources
    Given a logged in customer
    When I go to the home page
    Then I should not see "Order Items"
    And I should not see "Item Prices"
    And I click on the link "My Account"
    Then I should see "Account: Alex Egan"
    And I should see "Addresses on file"
    And I should see "Order History"
    When I click on the link "Items"
    Then I should see "Breads"
    And I should see "Pastries"
    And I should see "Muffins"
    And I should see "Popular Today"
    When I click on the link "View Cart"
    Then I should see "Your cart is currently empty."
    When I click on the link "My Orders"
    Then I should see "All Orders"
    And I should see "Date"
    And I should see "Recipient"
    And I should see "Item Count"
    And I should see "Weight"
    And I should see "Cost"



