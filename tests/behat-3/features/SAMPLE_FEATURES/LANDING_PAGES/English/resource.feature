Feature: I want to test the 'resource' page
    @javascript @anon
    Scenario: As an anonymous user I want to make sure that the resource page works properly
        Given I visit "/resources"
        Then I should see text matching "RESOURCES"
        Then I should see text matching "ADD RESOURCE"
        Then I should see text matching "Type"
        Then I should see text matching "Sectors"
        Then I should see text matching "Topics"
        Then I should see text matching "Program"
        Then I should see text matching "Region"
        Then I should see text matching "Country"
        Then I should see text matching "Organizations"

    @api @javascript @admin
    Scenario: As an administrator user I want to make sure that the resource page works properly
        Given I am logged in as a user with the "administrator" roles
        Given I visit "/resources"
        Then I should see text matching "RESOURCES"
        Then I should see text matching "ADD RESOURCE"
        Then I should see text matching "Type"
        Then I should see text matching "Sectors"
        Then I should see text matching "Topics"
        Then I should see text matching "Program"
        Then I should see text matching "Region"
        Then I should see text matching "Country"
        Then I should see text matching "Organizations"
