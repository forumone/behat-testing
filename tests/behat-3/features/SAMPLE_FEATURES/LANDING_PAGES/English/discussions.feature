Feature: I want to test the 'discussions' page
    @javascript @anon
    Scenario: As an anonymous user I want to make sure that the discussions page works properly
        Given I visit "/discussions"
        Then I should see text matching "Discussions"
        Then I should see the link "Start a Discussion"
        Then I should see text matching "Filter By"
        Then I should see text matching "Topics"
        Then I should see text matching "Regions"
        Then I should see text matching "Sectors"
        Then I should see text matching "Programs"

    @api @javascript @admin
    Scenario: As an administrator user I want to make sure that the discussions page works properly
        Given I am logged in as a user with the "administrator" roles
        Given I visit "/discussions"
        Then I should see text matching "Discussions"
        Then I should see the link "Start a Discussion"
        Then I should see text matching "Filter By"
        Then I should see text matching "Topics"
        Then I should see text matching "Regions"
        Then I should see text matching "Sectors"
        Then I should see text matching "Programs"