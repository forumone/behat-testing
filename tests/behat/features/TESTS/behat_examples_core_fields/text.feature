Feature: Create boolean field test

  @api @content @javascript @text @core
  Scenario: As an Administrator I want make sure the text value field is working
    Given I am logged in as a user with the "administrator" role
    When I visit "node/add/text"
    Then I should see the text "Create Text Field"
    Then for "Title" I enter "Testing Text"
    Then I should see the text "Fill out the text field above with text values"
    Then for "Text" I enter "Lorem ipsum dolor sit amet."
    Then I press "Save"
    Then I should see "Testing Text"
    And I should see "Lorem ipsum dolor sit amet."

  # Below is a similar test using the Drupal API Drive
  @api @content @javascript @text @core
  Scenario: Create nodes with text fields
    # The Drupal API allows us to create content using 'Given "content_type" content
    # and to fill in the values of fields using Gherkin
    Given "term reference" content:
      | title                                | text |
      | Testing Text with Drupal API Driver | Lorem ipsum dolor sit amet.  |

    And I am logged in as a user with the "administrator" role
    When I visit "admin/content"
    Then I should see the text "Testing Text with Drupal API Driver"