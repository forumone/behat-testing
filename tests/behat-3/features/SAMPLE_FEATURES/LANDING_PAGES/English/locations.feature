Feature: I want to test the 'locations' page
    @javascript @anon
    Scenario: As an anonymous user I want to make sure that the locations page works properly
        Given I visit "/locations"
        Then I should see text matching "LOCATIONS"
        Then I should see text matching "Africa"
        Then I should see text matching "Asia and Pacific"
        Then I should see text matching "Europe and Eurasia"
        Then I should see text matching "Global"
        Then I should see text matching "Indonesia"
        Then I should see text matching "Latin America / Caribbean"
        Then I should see text matching "Middle East"
        Then I should see text matching "North America"

    @api @javascript @admin
    Scenario: As an administrator user I want to make sure that the locations page works properly
        Given I am logged in as a user with the "administrator" roles
        Given I visit "/locations"
        Then I should see text matching "LOCATIONS"
        Then I should see text matching "Africa"
        Then I should see text matching "Asia and Pacific"
        Then I should see text matching "Europe and Eurasia"
        Then I should see text matching "Global"
        Then I should see text matching "Indonesia"
        Then I should see text matching "Latin America / Caribbean"
        Then I should see text matching "Middle East"
        Then I should see text matching "North America"