Feature: I want to test the 'partners' page
    @javascript @anon
    Scenario: As an anonymous user I want to make sure that the partners page works properly
        Given I visit "/partners"
        Then I should see text matching "Exchange Partners"

    @api @javascript @admin
    Scenario: As an administrator user I want to make sure that the partners page works properly
        Given I am logged in as a user with the "administrator" roles
        Given I visit "/partners"
        Then I should see text matching "Exchange Partners"
