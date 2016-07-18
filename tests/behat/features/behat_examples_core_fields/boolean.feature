Feature: Create boolean field test

  @api @content @javascript @boolean
  Scenario: As an Administrator I want make sure the boolean value field is working
    Given I am logged in as a user with the "administrator" role
    When I visit "node/add/boolean"
    Then I should see the text "Create Boolean"
    Then for "Title" I enter "Testing Boolean"
    Then I should see the text "Choose yes or no"
    Then I select the radio button "Yes" with the id "edit-field-boolean-und-1"
    Then I press "Save"
    Then I should see "Testing Boolean"
    And I should see "Yes"