Feature: Create boolean field test

  @api @content @javascript @integer @core
  Scenario: As an Administrator I want make sure the integer value field is working
    Given I am logged in as a user with the "administrator" role
    When I visit "node/add/integer"
    Then I should see the text "Create Integer"
    Then for "Title" I enter "Testing Integer"
    Then I should see the text "Add an integer value. The value should not contain a decimal."
    Then for "Integer" I enter "123456"
    Then I press "Save"
    Then I should see "Testing Integer"
    And I should see "123456"

  # Below is a similar test using the Drupal API Drive
  @api @content @javascript @integer @core
  Scenario: Create nodes with integer fields
    # The Drupal API allows us to create content using 'Given "content_type" content
    # and to fill in the values of fields using Gherkin
    Given "integer" content:
      | title                                                     | integer | promote |
      | Test Page One Integer with Drupal API Driver              | 123456  | 0       |
      | Test Page Two Integer with Drupal API Driver              | 654321  | 0       |
      | Test Page Three Integer with Drupal API Driver - Promoted | 246810  | 1       |

    And I am logged in as a user with the "administrator" role
    When I visit "admin/content"
    Then I should see the text "Test Page One Integer with Drupal API Driver"
    And I should see the text "Test Page Two Integer with Drupal API Driver "
    And I should see the text "Test Page Three Integer with Drupal API Driver - Promoted "
    When I am on the homepage
    Then I should not see the text "Test Page One Integer with Drupal API Driver"
    And I should not see the text "Test Page Two Integer with Drupal API Driver"
    And I should see the text "Test Page Three Integer with Drupal API Driver - Promoted"