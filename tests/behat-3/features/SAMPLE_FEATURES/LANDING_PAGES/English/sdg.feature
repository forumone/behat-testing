Feature: I want to test the 'sdg' page
    @javascript @anon
    Scenario: As an anonymous user I want to make sure that the sdg page works properly
        Given I visit "/sdg"
        Then I should see text matching "SUSTAINABLE DEVELOPMENT GOALS ON THE EXCHANGE"
        Then I should see text matching "ABOUT THE SDG'S"
        Then I should see text matching "SHARE YOUR INNOVATION"

    @api @javascript @admin
    Scenario: As an administrator user I want to make sure that the sdg page works properly
        Given I am logged in as a user with the "administrator" roles
        Given I visit "/sdg"
        Then I should see text matching "SUSTAINABLE DEVELOPMENT GOALS ON THE EXCHANGE"
        Then I should see text matching "ABOUT THE SDG'S"
        Then I should see text matching "SHARE YOUR INNOVATION"
