Feature: Create boolean field test

  @api @content @javascript @list @core
  Scenario: As an Administrator I want make sure the list field is working
    Given I am logged in as a user with the "administrator" role
    When I visit "node/add/list"
    Then I should see the text "Create List"
    Then for "Title" I enter "Testing List"
    Then I should see the text "Select a color from the list."
    Then I select "Orange" from "List"
    Then I press "Save"
    Then I should see "Testing List"
    And I should see "Orange"