Feature: Create boolean field test

  @api @content @javascript @image @core
  Scenario: As an Administrator I want make sure the image field is working
    Given I am logged in as a user with the "administrator" role
    When I visit "node/add/image"
    Then I should see the text "Create Image"
    Then for "Title" I enter "Testing Image"
    And I should see the text "Allowed file types: txt."
    Then I attach the file "image.jpg" to "Image"
    Then I wait for AJAX to finish
    Then I press "Save"
    Then I should see "Testing Image"
    And I should see "Test Image Description"
    Then I click "Test Image Description"
    Then I should see "testfile.txt"