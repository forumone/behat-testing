Feature: Email Digest Functionality

  @api @content @javascript
  Scenario: As an Administration user I want to make sure that I receieve emails when I am followed
    Given I am logged in as a user with the "administrator" role
    When I visit "/user"
    Then I should see the link "Edit"
    Then I click "Edit"
    Then I select "Immediate" from "edit-field-user-notifications-und"
    Then I fill in "First Name" with "Test1"
    Then I fill in "Last Name" with "Test2"
    Then I check the box "Receive emails when I am followed"
    Then I press "Save"
    Then I should see the text "The changes have been saved"
    Given I am logged in as a user with the "authenticated" role
    When I visit "/user/1"
    Then I click "Follow"