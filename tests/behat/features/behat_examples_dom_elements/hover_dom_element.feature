Feature: Create DOM Element test

  As a Drupal authenticated user
  I should be able to hover over the home icon and see 'Home'

  @api @javascript @dom_elements @hover
  Scenario: Hover over 'Home' icon

    Given I am logged in as "admin"
    Given I am at "/admin/content"
    When I hover over the element "div.add-or-remove-shortcuts"
    Then I should see "Remove from default shortcuts"

