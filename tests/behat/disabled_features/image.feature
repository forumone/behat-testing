Feature: Create boolean field test

  @api @content @javascript @image @core
  Scenario: As an Administrator I want make sure the file field is working
    Given I am logged in as a user with the "administrator" role
    When I visit "node/add/image"
    Then I should see the text "Create Image"
    Then for "Title" I enter "Testing Image"
    Then I attach the file "beehat-drupalicon.png" to "Image"
    Then I press "Upload"
    Then I wait for AJAX to finish
    Then I should see "Alternate text"
    And I should see "Title"
    Then for "Alternate text" I enter "Behat extension logo"
    Then for "Title" I enter "Behat"
    Then I press "Save"
    Then I should see "Testing Image"
    And I should see "Image:"
    #todo This is still failing
    And I should see an "img" element

  # Below is a similar test using the Drupal API Drive
  @api @content @javascript @image @core
  Scenario: Create nodes with fields
    # The Drupal API allows us to create content using 'Given "content_type" content
    # and to fill in the values of fields using Gherkin
    Given "file" content:
      | title                               | image     |
      | Testing Image with Drupal API Driver | beehat-drupalicon.png |

    And I am logged in as a user with the "administrator" role
    When I visit "admin/content"
    Then I should see the text "Testing Image with Drupal API Driver"