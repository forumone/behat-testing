Feature: I want to test the 'team' page
    @javascript @anon
    Scenario: As an anonymous user I want to make sure that the team page works properly
        Given I visit "/team"
        Then I should see text matching "Exchange Team"
        Then I should see text matching "Exchange Champions"
        Then I should see text matching "Alumni"

    @api @javascript @admin
    Scenario: As an administrator user I want to make sure that the team page works properly
        Given I am logged in as a user with the "administrator" roles
        Given I visit "/team"
        Then I should see text matching "Exchange Team"
        Then I should see text matching "Exchange Champions"
        Then I should see text matching "Alumni"
