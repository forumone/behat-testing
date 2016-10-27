Feature: Create boolean field test

  @api @content @javascript @boolean @core
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

#    Below is the same test using the Drupal API Drive
  @api @content @javascript @boolean @core
  Scenario: Create nodes with fields
    # The Drupal API allows us to create content using 'Given "content_type" content
    # and to fill in the values of fields using Gherkin
    Given "boolean" content:
      | title                             | boolean |
      | Testing Boolean Drupal API Driver | yes     |

    And I am logged in as a user with the "administrator" role
    When I visit "admin/content"
    Then I should see the text "Testing Boolean Drupal API Driver"
    Given


