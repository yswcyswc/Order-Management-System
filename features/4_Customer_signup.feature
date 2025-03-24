Feature: Customer Sign-Up
  As a guest
  I want to create a customer account on the system
  In order to place orders

  Scenario: Prior to sign-up, there is no cart
    Given an initial setup
    When I go to the items page
    Then I should not see "View Cart"
    When I click on the link "Chocolate Zucchini Muffins"
    Then I should not see "Add to Cart"
    And I should not see "Checkout"

  Scenario: Sign-up successful
    Given an initial setup
    When I go to the home page
    And I click on the link "Become a Customer"
    Then I should not see "Role"
    When I fill in "customer_first_name" with "Ed"
    And I fill in "customer_last_name" with "Gruberman"
    And I fill in "customer_phone" with "412-268-2323"
    And I fill in "customer_email" with "gruberman@example.com"
    And I fill in "customer_user_attributes_username" with "egruberman"
    And I fill in "customer_user_attributes_password" with "secret"
    And I fill in "customer_user_attributes_password_confirmation" with "secret"
    And I press "Register"
    Then I should see "Ed Gruberman"
    And I should see "Phone: 412-268-2323"
    And I should see "Active: Yes"
    And I should see "A Roi du Pain customer since 2025"
    And I should see "View Cart"
    And I should not see "Become a Customer"
    And I should not see "Login"
    And I should see "Logout"
    And I should not see "Addresses on file"
