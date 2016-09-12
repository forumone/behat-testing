Feature: Create a Views test

  @api @content @view

  Scenario: Check the Footer
    Given I am at "/"
    And I press "Search" in the "header" region
  I fill in "a value" for "a field" in the "content" region
  I fill in "a field" with "Stuff" in the "header" region
  I click "About us" in the "footer" region