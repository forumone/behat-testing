Feature: I want to test the 'events' page
    @javascript @anon
    Scenario: As an anonymous user I want to make sure that the events page works properly
        Given I visit "/events"
        Then I should see text matching "EVENTS"
        Then I should see text matching "ADD AN EVENT"
        Then I should see text matching "Event Type"
        Then I should see text matching "Country"
        Then I should see text matching "Sector"
        Then I should see text matching "Topic"
        Then I should see text matching "Region"
        Then I should see text matching "Cost"
        Then I should see text matching "Start date"

    @api @javascript @admin
    Scenario: As an administrator user I want to make sure that the events page works properly
        Given I am logged in as a user with the "administrator" roles
        Given I visit "/events"
        Then I should see text matching "EVENTS"
        Then I should see text matching "ADD AN EVENT"
        Then I should see text matching "Event Type"
        Then I should see text matching "Country"
        Then I should see text matching "Sector"
        Then I should see text matching "Topic"
        Then I should see text matching "Region"
        Then I should see text matching "Cost"
        Then I should see text matching "Start date"
