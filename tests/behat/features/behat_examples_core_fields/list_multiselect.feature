Feature: Create boolean field test

  @api @content @javascript @list_multiselect @core
  Scenario: As an Administrator I want make sure the list field is working and allows multiple values
    Given I am logged in as a user with the "administrator" role
    When I visit "node/add/list"
    Then I should see the text "Create List"
    Then for "Title" I enter "Testing List"
    Then I should see the text "Select a color from the list."
    Then I select "Red" from "List"
    And I select "Green" from "List"
    Then I press "Save"
    Then I should see "Testing List"
    And I should see "Red"
    And I should see "Green"

  # Below is a similar test using the Drupal API Drive
  @api @content @javascript @list_multiselect @core
  Scenario: Create nodes with multiselect list fields
    # The Drupal API allows us to create content using 'Given "content_type" content
    # and to fill in the values of fields using Gherkin
    Given "list" content:
      | title                                           | list       |
      | Testing Multiple Value Select List with Drupal API Driver | Red, Green |

    And I am logged in as a user with the "administrator" role
    When I visit "admin/content"
    Then I should see the text "Testing Multiple Value Select List with Drupal API Driver"