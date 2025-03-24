Feature: View Items for Customer
  As a customer
  I want to be able to view item lists and details
  So I can identify items I am interested in purchasing

  Background:
    # Given an initial setup
    Given a logged in customer

  # READ METHODS
  Scenario: View item list page
    When I go to the items page
    Then I should see "Breads"
    And I should see "Name"
    And I should see "Weight"
    And I should see "Price"
    And I should see "Challah Bread"
    And I should see "0.9"
    And I should see "$5.75"
    And I should see "Cinnamon Swirl Bread"
    And I should see "1.0"
    And I should see "$5.50"
    And I should see "Popular Today"
    And I should see "1. Honey Wheat Bread"
    And I should see "2. Sourdough Bread"
    And I should see "Muffins"
    And I should see "Blueberry Muffins"
    And I should see "$8.95"
    And I should see "Pastries"
    And I should see "Crossiants"
    And I should see "$9.50"
    And I should not see "Apple Cherry Bread"
    And I should not see "$6.50"
    And I should not see "Inactive"
    And I should not see "Add a New Item"

  Scenario: The item name is a link to details
    When I go to the items page
    And I click on the link "Chocolate Zucchini Muffins"
    Then I should see "A tasty recipie our mom used to make to get us to eat our veggies as often as possible with the least complaining possible. Your kids will love them too!"
    And I should see "Units Per Item: 12"
    And I should see "Current Price: $9.25"
    And I should see "Similar Items"
    And I should see "Blueberry Muffins"
    And I should not see "Honey Wheat Bread"
    And I should not see "Sourdough Bread"
    And I should not see "Crossiants"
    And I should see "Add to Cart"
    And I should see "Display All"
    And I should not see "Edit Chocolate Zucchini Muffins"
    And I should not see "Edit Blueberry Muffins"
    And I should not see "Edit Item"
    And I should not see "Price History"




