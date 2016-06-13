Feature: I want to test the 'funding' page
    @javascript @anon
    Scenario: As an anonymous user I want to make sure that the funding page works properly
        Given I visit "/funding"
        Then I should see text matching "FUNDING OPPORTUNITIES"
        Then I should see text matching "ADD FUNDING OPP"
        Then I should see text matching "Filter By"
        Then I should see text matching "Funding Type"
        Then I should see text matching "Estimated Time To Complete Application"
        Then I should see text matching "Sectors"
        Then I should see text matching "Topics"
        Then I should see text matching "Region"
        Then I should see text matching "Country"
        Then I should see text matching "Organizations"

    @api @javascript @admin
    Scenario: As an administrator user I want to make sure that the funding page works properly
        Given I am logged in as a user with the "administrator" roles
        Given I visit "/funding"
        Then I should see text matching "FUNDING OPPORTUNITIES"
        Then I should see text matching "ADD FUNDING OPP"
        Then I should see text matching "Filter By"
        Then I should see text matching "Funding Type"
        Then I should see text matching "Estimated Time To Complete Application"
        Then I should see text matching "Sectors"
        Then I should see text matching "Topics"
        Then I should see text matching "Region"
        Then I should see text matching "Country"
        Then I should see text matching "Organizations"
