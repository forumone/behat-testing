Feature: I want to test a Basic Drupal 7 Site

  @api @javascript
  Scenario: As an administrator I want to make sure I can see the homepage
    Given I am logged in as a user with the "administrator" roles
    When I visit "/"
    Then I should see text matching "No front page content has been created yet."
