Feature: Create boolean field test

  @api @content @javascript @float
  Scenario: As an Administrator I want make sure the boolean value field is working
    Given I am logged in as a user with the "administrator" role
    When I visit "node/add/float"
    Then I should see the text "Create Float Field"
    Then for "Title" I enter "Testing Float"
    Then I should see the text "Add a numerical value with a decimal"
    Then for "Float" I enter "145.67837892"
    Then I press "Save"
    Then I should see "Testing Float"
    And I should see "145.68"