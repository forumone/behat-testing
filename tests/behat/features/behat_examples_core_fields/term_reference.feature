Feature: Create boolean field test

  @api @content  @term @core
  Scenario: As an Administrator I want make sure the term reference value field is working
    Given I am logged in as a user with the "administrator" role
    When I visit "node/add/behat_term-ref"
    Then I should see the text "Create Term Reference"
    Then for "Title" I enter "Testing Term Reference"
    Then I should see the text "Add a term"
    Then for "Term Reference" I enter "Wizbam"
    Then I press "Save"
    Then I should see "Testing Term Reference"
    And I should see "Wizbam"

  # Below is a similar test using the Drupal API Drive
  @api @content  @term @core
  Scenario: Create nodes with fields
    # The Drupal API allows us to create content using 'Given "behat_content_type" content
    # and to fill in the values of fields using Gherkin
    Given "behat_term_ref" content:
      | title                                         | term reference |
      | Testing Term Reference with Drupal API Driver | Wizbam         |

    And I am logged in as a user with the "administrator" role
    When I visit "admin/content"
    Then I should see the text "Testing Term Reference with Drupal API Driver"
    When I visit "/admin/structure/taxonomy/tags"
    Then I should see "Wizbam"