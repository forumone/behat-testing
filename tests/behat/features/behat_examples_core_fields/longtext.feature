Feature: Create boolean field test

  @api @content  @longtext @core
  Scenario: As an Administrator I want make sure the longtext value field is working
    Given I am logged in as a user with the "administrator" role
    When I visit "node/add/behat_longtext"
    Then I should see the text "Create Long Text Field"
    Then for "Title" I enter "Testing Long Text"
    Then I should see the text "Text format"
    Then for "Long Text" I enter "Morbi mollis accumsan ante. Morbi vel ornare nisl, quis posuere justo. Cras fringilla eu tortor a tristique. Maecenas vitae commodo ipsum, vitae dignissim augue. "

    Then I press "Save"
    Then I should see "Testing Long Text"
    And I should see "Morbi mollis accumsan ante. Morbi vel ornare nisl, quis posuere justo. Cras fringilla eu tortor a tristique. Maecenas vitae commodo ipsum, vitae dignissim augue."

  # Below is a similar test using the Drupal API Drive
  @api @content  @longtext @core
  Scenario: Create nodes with multiselect list fields
    # The Drupal API allows us to create content using 'Given "behat_content_type" content
    # and to fill in the values of fields using Gherkin
    Given "behat_longtext" content:
      | title                                   | longtext                                                                                                                                                          |
      | Testing Longtext with Drupal API Driver | Morbi mollis accumsan ante. Morbi vel ornare nisl, quis posuere justo. Cras fringilla eu tortor a tristique. Maecenas vitae commodo ipsum, vitae dignissim augue. |

    And I am logged in as a user with the "administrator" role
    When I visit "admin/content"
    Then I should see the text "Testing Longtext with Drupal API Driver"



