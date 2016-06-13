Feature: I want to test basics search functionality

  @api @anon @javascript
  Scenario: As an anonymous user I want to check that I can see basic content on the search page
    Given I retrieve "random" content to search on the site
    Then I check that the content is "available" on the search page

  @api @anon @javascript
  Scenario: As an anonymous user I want to check that I can see basic content on the search page
    Given I am logged in as a user with the "administrator" role
    Given "long_form_page" content:
      | title          | author     | status | created           |
      | Long Form Test2 | admin      | 1      | 2014-10-17 8:00am |
    Then I check that the content is "not available" on the search page

  @api @anon @javascript
  Scenario: As an anonymous user I want to check that I can not see longform content on the search page
    Given I create "long-form" content to search on the site
    Then I check that the content is "not available" on the search page

  @api @anon @javascript
  Scenario: As an anonymous user I want to check that I can not see microsite type content on the search page
    Given I create "microsite-type" content to search on the site
    Then I check that the content is "not available" on the search page

  @api @anon @javascript
  Scenario: As an anonymous user I want to check that I can not see microsite page type content on the search page
    Given I create "micorosite-page-type" content to search on the site
    Then I check that the content is "not available" on the search page

  @api @anon @javascript
  Scenario: As an anonymous user I want to check that I can not see microsite affiliated content on the search page
    Given I create "microsite-affilated" content to search on the site
    Then I check that the content is "not available" on the search page

  @api @anon @javascript
  Scenario: As an anonymous user I want to check that I can not see action cards content on the search page
    Given I create "action-cards" content to search on the site
    Then I check that the content is "not available" on the search page

  @api @anon @javascript
  Scenario: As an anonymous user I want to check that I can not see error pages content on the search page
    Given I create "error-pages" content to search on the site
    Then I check that the content is "not available" on the search page

  @api @anon @javascript
  Scenario: As an anonymous user I want to check that I can not see homepage content on the search page
    Given I create "homepage" content to search on the site
    Then I check that the content is "not available" on the search page

  @api @anon @javascript
  Scenario: As an anonymous user I want to check that I can not see persona content on the search page
    Given I create "persona" content to search on the site
    Then I check that the content is "not available" on the search page