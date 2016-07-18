Feature: Create boolean field test

  @api @content @javascript @text
  Scenario: As an Administrator I want make sure the text value field is working
    Given I am logged in as a user with the "administrator" role
    When I visit "node/add/text"
    Then I should see the text "Create Text Field"
    Then for "Title" I enter "Testing Text"
    Then I should see the text "Fill out the text field above with text values"
    Then for "Text" I enter "Lorem ipsum dolor sit amet."
    Then I press "Save"
    Then I should see "Testing Text"
    And I should see "Lorem ipsum dolor sit amet."