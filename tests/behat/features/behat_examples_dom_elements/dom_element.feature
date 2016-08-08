Feature: Create DOM Element test

  @api @content @javascript @dom_elements @core
  Scenario: As an Administrator I want make sure the longtext value field is working
    Given I am logged in as a user with the "administrator" role
    When I visit "node/add/longtext"
    Then for "Title" I enter "Testing DOM Element"
    Then I should see the text "Text format"
    Then I select "Full HTML" from "Text format"
    # Including inline styling in the body field to test DOM element rendering
    Then for "Long Text" I enter '<p><h1 class="behat">This is a Header</h1></p><p>Morbi mollis accumsan ante. <div id="behat">Morbi vel ornare nisl, quis posuere justo.</div> <ul class="behat"><li class="list">Cras fringilla eu tortor a tristique.</li><li class="list">Sed augue.</li></ul> Maecenas vitae commodo ipsum, vitae dignissim augue.</p>'
    Then I press "Save"
    Then I should see "Testing DOM Element"
    # Using CSS selectors to target DOM elements and verify that text is rendered within correct elements ids and classes
    # h1 with class
    And I should see "This is a Header" in the "h1.behat" element
    # div with id
    And I should see "Morbi vel ornare nisl, quis posuere justo" in the "div#behat" element
    # unordered list checking the first child
    And I should see "Cras fringilla eu tortor a tristique." in the "ul.behat li:first-child" element
    # unordered list checking the second child
    And I should see "Sed augue." in the "ul.behat li:nth-child(2)" element

  # Below is a similar test using the Drupal API Drive
  @api @content @javascript @dom_elements @core
  Scenario: Create nodes with multiselect list fields
    # The Drupal API allows us to create content using 'Given "content_type" content
    # and to fill in the values of fields using Gherkin
    Given "longtext" content:
      | title                                   | longtext                 |
      | Testing DOM Element with Drupal API Driver | <p><h1 class="behat">This is a Header</h1></p><p>Morbi mollis accumsan ante. Morbi vel ornare nisl, quis posuere justo. Cras fringilla eu tortor a tristique. Maecenas vitae commodo ipsum, vitae dignissim augue.</p> |

    And I am logged in as a user with the "administrator" role
    When I visit "/admin/content"
    Then I should see the text "Testing DOM Element with Drupal API Driver"



