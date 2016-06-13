Feature: I want to test the 'organizations' page
    @javascript @anon
    Scenario: As an anonymous user I want to make sure that the organizations page works properly
        Given I visit "/organizations"
        Then I should see text matching "ORGANIZATIONS"
        Then I should see text matching "ADD AN ORGANIZATION"
        Then I should see text matching "Sectors"
        Then I should see text matching "Regions"
        Then I should see text matching "Country"
        Then I should see text matching "Type"

    @api @javascript @admin
    Scenario: As an administrator user I want to make sure that the organizations page works properly
        Given I am logged in as a user with the "administrator" roles
        Given I visit "/organizations"
        Then I should see text matching "ORGANIZATIONS"
        Then I should see text matching "ADD AN ORGANIZATION"
        Then I should see text matching "Sectors"
        Then I should see text matching "Regions"
        Then I should see text matching "Country"
        Then I should see text matching "Type"
