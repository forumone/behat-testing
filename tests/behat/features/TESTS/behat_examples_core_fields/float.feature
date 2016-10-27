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

    #    Below is a similar test using the Drupal API Drive
  @api @content @javascript @float @core
  Scenario: Create nodes with fields
    # The Drupal API allows us to create content using 'Given "content_type" content
    # and to fill in the values of fields using Gherkin
    Given "float" content:
      | title                           | float        |
      | Testing Float with Drupal API Driver | 145.67837892 |

    And I am logged in as a user with the "administrator" role
    When I visit "admin/content"
    Then I should see the text "Testing Float with Drupal API Driver"