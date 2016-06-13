Feature: I want to test the 'faq' page
    @javascript @anon
    Scenario: As an anonymous user I want to make sure that the faq page works properly
        Given I visit "/frequently-asked-questions"
        Then I should see text matching "Frequently Asked Questions"

    @api @javascript @admin
    Scenario: As an administrator user I want to make sure that the faq page works properly
        Given I am logged in as a user with the "administrator" roles
        Given I visit "/frequently-asked-questions"
        Then I should see text matching "Frequently Asked Questions"

