Feature: Create boolean field test

  @api @content @javascript @term
  Scenario: As an Administrator I want make sure the boolean value field is working
    Given I am logged in as a user with the "administrator" role
    When I visit "node/add/term-reference"
    Then I should see the text "Create Term Reference"
    Then for "Title" I enter "Testing Term Reference"
    Then I should see the text "Add a term"
    Then for "Term Reference" I enter "Wizbam"
    Then I press "Save"
    Then I should see "Testing Term Reference"
    And I should see "Wizbam"