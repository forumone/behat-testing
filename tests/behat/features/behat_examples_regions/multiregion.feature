Feature: Test for content in the Header and Content regions

  @api @content @view @regions @multi-region
  Scenario: Check ability to edit 'My Account' using link
    Given I am logged in as a user with the "administrator" role
    And I am at "/"
    When I click "My account" in the "header" region
    Then I click "Edit" in the "content" region
    Then I should see "Username"