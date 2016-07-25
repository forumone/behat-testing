Feature: Create boolean field test

  @api @content @javascript @float @core
  Scenario: As an Administrator I want make sure the float value field is working
    Given I am logged in as a user with the "administrator" role
    When I visit "node/add/float"
    Then I should see the text "Create Float Field"
    Then for "Title" I enter "Testing Float"
    Then I should see the text "Add a numerical value with a decimal"
    Then for "Float" I enter "145.67837892"
    Then I press "Save"
    Then I should see "Testing Float"
    # Note that the returned float value is rounded up by Drupal to the nearest 100th point (8).
    # This is the desired behavior.
    And I should see "145.68"