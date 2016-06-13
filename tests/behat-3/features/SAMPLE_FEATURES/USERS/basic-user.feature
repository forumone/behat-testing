Feature: I want to test basic user functionality

  @api
  Scenario: As an administrator I want to create and apply all available roles to users
    Given users:
      | name            | mail              | roles                     | pass  |
      | Intern_Test     | intern@bar.com    | Intern                    | test  |
      | Location_Test   | location@bar.com  | Location Manager          | test  |
      | Microsite_Test  | microsite@bar.com | Microsite Administrator   | test  |
      | Program_Test    | program@bar.com   | Program Community Manager | test  |
      | Sector_Test     | sector@bar.com    | Sector Manager            | test  |
      | Topic_Test      | topic@bar.com     | Topic Manager             | test  |


  @api @javascript
  Scenario: As an administrator I want to create authenticated users and than apply roles to them
    Given users:
      | name            | mail                         | roles               | pass  |
      | Intern_Test     | intern24@bar.com             | authenticated user  | test  |
      | Location_Test   | location24@bar.com           | authenticated user  | test  |
      | Microsite_Test  | microsite24@bar.com          | authenticated user  | test  |
      | Program_Test    | program24@bar.com            | authenticated user  | test  |
      | Sector_Test     | sector24@bar.com             | authenticated user  | test  |
      | Topic_Test      | topic24@bar.com              | authenticated user  | test  |
    Given I am logged in as a user with the "administrator" role
    Then I will visit the user edit screen and apply a new role to each user

  @api @javascript
  Scenario: As an administrator I want to create an authenticated user and add properly formatted social media urls to them
    Given users:
      | name                 | mail                               | roles               | pass  |
      | Intern_Test     | intern24@bar.com             | authenticated user  | test  |
      | Location_Test   | location24@bar.com           | authenticated user  | test  |
      | Microsite_Test  | microsite24@bar.com          | authenticated user  | test  |
    Given I am logged in as a user with the "administrator" role
    Then I visit the user edit screen and apply a social media url to each user