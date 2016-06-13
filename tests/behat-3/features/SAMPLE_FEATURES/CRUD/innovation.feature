Feature: Create innovation content test

  @api @content @javascript
  Scenario: As an Administration user I want to make sure that the Innovation content type is created properly
    Given I am logged in as a user with the "administrator" role
    When I visit "node/add/innovation"
    Then I should see the text "Create Innovation"
    Then I should see the text "Tell us about your innovation"
    Then I fill in "edit-title-field-und-0-value" with "Test Innovation"
    Then I fill in CKEditor field "edit-field-innovation-desc-und-0-value" with "blunderbuss"
    Given I select "United States" from "Country" chosen.js select box
    Then I wait for text "Address 1" to appear
    Then I fill in "Address 1" with "1600 Pennsylvania"
    Then I fill in "City" with "Washington"
    Given I select "District of Columbia" from "State" chosen.js select box
    Then I fill in "ZIP code " with "20002"
    Then I check the box "Agriculture"
    Given I select "Global" from "edit-field-term-region-und" chosen.js autoselect box
    Given I select "Global" from "edit-field-innovation-created-und" chosen.js autoselect box
    Given I select "Global" from "edit-field-innovation-implemented-und" chosen.js autoselect box
    Then I press "Save"
    Then I should see "Innovation Test Innovation has been created"
    When I visit "innovations/sector/agriculture-281"
    Then I should see "Test Innovation"
    Then I should see "blunderbuss"

