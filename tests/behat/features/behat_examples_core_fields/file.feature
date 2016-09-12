Feature: Create boolean field test

  @api @content @javascript @file @core
  Scenario: As an Administrator I want make sure the file field is working
    Given I am logged in as a user with the "administrator" role
    When I visit "node/add/file"
    Then I should see the text "Create File"
    Then for "Title" I enter "Testing File"
    And I should see the text "Allowed file types: txt pdf doc."
    Then I attach the file "text.txt" to "File"
    Then I press "Upload"
    Then I wait for AJAX to finish
    Then I should see "Description"
    Then for "Description" I enter "Test File Description"
    Then I press "Save"
    Then I should see "Testing File"
    And I should see "Test File Description"

  # Below is a similar test using the Drupal API Drive
  @api @content @javascript @file @core
  Scenario: Create nodes with fields
    # The Drupal API allows us to create content using 'Given "content_type" content
    # and to fill in the values of fields using Gherkin
    Given "file" content:
      | title                               | file     |
      | Testing File with Drupal API Driver | test.txt |

    And I am logged in as a user with the "administrator" role
    When I visit "admin/content"
    Then I should see the text "Testing File with Drupal API Driver"