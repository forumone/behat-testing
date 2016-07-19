Feature: Create boolean field test

  @api @content @javascript @file
  Scenario: As an Administrator I want make sure the file field is working
    Given I am logged in as a user with the "administrator" role
    When I visit "node/add/file"
    Then I should see the text "Create File"
    Then for "Title" I enter "Testing File"
    And I should see the text "Allowed file types: txt."
    Then I attach the file "textfile.txt" to "File"
    Then I wait for AJAX to finish
    Then I should see "Description"
    Then for "Description" I enter "Test File Description"
    Then I press "Save"
    Then I should see "Testing File"
    And I should see "Test File Description"
    Then I click "Test File Description"
    Then I should see "testfile.txt"