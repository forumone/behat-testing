Feature: I want to test the 'programs' page
    @javascript @anon
    Scenario: As an anonymous user I want to make sure that the programs page works properly
        Given I visit "/programs"
        Then I should see text matching "PROGRAMS"
        Then I should see text matching "ADD A PROGRAM"
        Then I should see text matching "Filter By"
        Then I should see text matching "Sectors"
        Then I should see text matching "Regions"
        Then I should see text matching "Country"

    @api @javascript @admin
    Scenario: As an administrator user I want to make sure that the programs page works properly
        Given I am logged in as a user with the "administrator" roles
        Given I visit "/programs"
        Then I should see text matching "PROGRAMS"
        Then I should see text matching "ADD A PROGRAM"
        Then I should see text matching "Filter By"
        Then I should see text matching "Sectors"
        Then I should see text matching "Regions"
        Then I should see text matching "Country"