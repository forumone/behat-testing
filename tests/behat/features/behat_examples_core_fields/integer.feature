Feature: Create boolean field test

  @api @content @javascript @integer
  Scenario: As an Administrator I want make sure the integer value field is working
    Given I am logged in as a user with the "administrator" role
    When I visit "node/add/integer"
    Then I should see the text "Create Integer"
    Then for "Title" I enter "Testing Integer"
    Then I should see the text "Choose yes or no"
    Then for "Integer" I enter "123456"
    Then I press "Save"
    Then I should see "Testing Integer"
    And I should see "123456"