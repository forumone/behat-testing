Feature: I want to test the 'about-exchange' page
    @javascript @anon
    Scenario: As an anonymous user I want to make sure that the about-exchange page works properly
        Given I visit "/about-exchange"
        Then I should see text matching "About the Exchange"

    @api @javascript @admin
    Scenario: As an administrator user I want to make sure that the about-exchange page works properly
        Given I am logged in as a user with the "administrator" roles
        Given I visit "/about-exchange"
        Then I should see text matching "About the Exchange"

