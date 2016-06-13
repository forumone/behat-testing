Feature: I want to test the 'innovators' page
    @javascript @anon
    Scenario: As an anonymous user I want to make sure that the innovators page works properly
        Given I visit "/members/field_user_type/29"
        Then I should see text matching "MEMBERS"
        Then I should see text matching "JOIN THE EXCHANGE"
        Then I should see text matching "Filter By"
        Then I should see text matching "Area of Interest"
        Then I should see text matching "Organization"
        Then I should see text matching "Program"
        Then I should see text matching "Sectors"
        Then I should see text matching "Region"
        Then I should see text matching "Country"
        Then I should see text matching "Assistance Type"
        Then I should see text matching "Role / Expertise"

    @api @javascript @admin
    Scenario: As an administrator user I want to make sure that the innovators page works properly
        Given I am logged in as a user with the "administrator" roles
        Given I visit "/members/field_user_type/29"
        Then I should see text matching "MEMBERS"
        Then I should see text matching "JOIN THE EXCHANGE"
        Then I should see text matching "Filter By"
        Then I should see text matching "Area of Interest"
        Then I should see text matching "Organization"
        Then I should see text matching "Program"
        Then I should see text matching "Sectors"
        Then I should see text matching "Region"
        Then I should see text matching "Country"
        Then I should see text matching "Assistance Type"
        Then I should see text matching "Role / Expertise"