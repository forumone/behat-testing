Feature: Test for content in the Header and Content regions

  @api @content @view @regions @header-region

  Scenario: Check the Header for My accoutn and Log out links

    Given I am logged in as a user with the "authenticated user" role
    And I am at "/"
    Then I should see "My account" in the "header" region
    And I should see "Log out" in the "header" region
    When I click "Log out" in the "header" region
    # Note: hyphenated classes should be replaced with underscores for region names
    # 'sidebar-first' becomes 'sidebar_first'
    Then I should see "User login" in the "sidebar_first" region
