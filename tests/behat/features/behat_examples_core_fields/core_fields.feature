Feature: Create a core_fields test

  @api @javascript @content @boolean @all_core
  Scenario: As an Administrator I want make sure the boolean value field is working
    Given I am logged in as a user with the "administrator" role
    When I visit "node/add/behat_core-fields"
    Then I should see the text "Create Core Fields"
    Then for "Title" I enter "Testing Core Fields"
    Then I should see the text "Choose yes or no."
    Then I select the radio button "Yes" with the id "edit-field-boolean-und-1"
    Then I should see the text "Fill out the text field above with text values."
    Then for "Text" I enter "Lorem ipsum dolor sit amet."
    Then I should see the text "Select a color from the list."
    Then I select "Orange" from "List"
    Then I should see the text "Add an integer value. The value should not contain a decimal."
    Then for "Integer" I enter "123456"
    Then I should see the text "Add a numerical value with a decimal."
    Then for "Float" I enter "145.67837892"
    Then I should see the text "Text format"
    # Note the lowercase 's' in 'summary' - Behat is case sensitive so this is important
    # Behat can 'click' a link id|title|alt|text
    Then I click "Edit summary"
    Then I should see "Hide summary"
    Then for "Summary" I enter "A short, concise summary"
    Then for "Long Text" I enter "Morbi mollis accumsan ante. Morbi vel ornare nisl, quis posuere justo. Cras fringilla eu tortor a tristique. Maecenas vitae commodo ipsum, vitae dignissim augue."
    Then I should see the text "Add a term"
    Then for "Term Reference" I enter "Wizbam"
    Then I attach the file "beehat-drupalicon.png" to "Image"
    Then I press "Upload"
    Then I wait for AJAX to finish
    Then I should see "Alternate text"
    And I should see "Title"
    Then for "Alternate text" I enter "Behat extension logo"
    Then for "Title" I enter "Behat"
    And I should see the text "Allowed file types: txt pdf doc."
    Then I attach the file "text.txt" to "File"
    Then I press "Upload"
    Then I wait for AJAX to finish
    Then I should see "Description"
    Then for "Description" I enter "Test File Description"

    #save the node
    Then I press "Save"

    #view the node after saving
    Then I should see "Testing Core Fields"
    And I should see "Yes"
    And I should see "Lorem ipsum dolor sit amet."
    And I should see "Orange"
    And I should see "123456"
    # Note that the returned float value is rounded up by Drupal to the nearest 100th point (8).
    # This is the desired behavior.
    And I should see "145.68"
    Then I should see "A short, concise summary"
    # Here we ensure that only the summary is displayed by default, per the content type Display settings
    # If the full body field is displayed, there is an issue with our Display settings
    And I should not see "Morbi mollis accumsan ante. Morbi vel ornare nisl, quis posuere justo. Cras fringilla eu tortor a tristique. Maecenas vitae commodo ipsum, vitae dignissim augue."
    And I should see "Wizbam"
    And I should see "Image:"
    And I should see an "img" element
    And I should see "Test File Description"
    # Comments should show on the node view
    And I should see "Add new comment"
    And I should see "Your name"
    Then for "Subject" I enter "This is a comment subject"
    Then for "Comment" I enter "This is a comment and it is short"
    Then I press "Save"
    Then I should see "This is a comment subject"
    And I should see "This is a comment and it is short"
    And I should see "delete"

  # This example makes use of a 'Scenario Outline', which allows us to test a set of values using placeholders
  # The string used for the "<placeholder>" can be anything, just like a normal variable. The placeholders must
  # be in the header row of the Gherkin table and the table must be preceded by 'Examples:'
  # http://docs.behat.org/en/v3.0/guides/1.gherkin.html

    Given "behat_Core Fields" content:
      | title                               | field_boolean | field_text                  | field_list_text | field_integer | field_float  | field_long_text_and_summary                                                                                                                                       | field_term_reference | field_image           | field_file |
      | Testing Core Fields with Drupal API | Yes           | Lorem ipsum dolor sit amet. | Orange          | 123456        | 145.67837892 | Morbi mollis accumsan ante. Morbi vel ornare nisl, quis posuere justo. Cras fringilla eu tortor a tristique. Maecenas vitae commodo ipsum, vitae dignissim augue. | Wizbam               | beehat-drupalicon.png | text.txt   |

    When I visit the node "1"
    Then I should see "Testing Core Fields with Drupal API"
    And I should see "Yes"
    And I should see "Lorem ipsum dolor sit amet."
    And I should see "Orange"
    And I should see "123456"
    # Note that the returned float value is rounded up by Drupal to the nearest 100th point (8).
    # This is the desired behavior.
    And I should see "145.68"
    Then I should see "A short, concise summary"
    # Here we ensure that only the summary is displayed by default, per the content type Display settings
    # If the full body field is displayed, there is an issue with our Display settings
    And I should not see "Morbi mollis accumsan ante. Morbi vel ornare nisl, quis posuere justo. Cras fringilla eu tortor a tristique. Maecenas vitae commodo ipsum, vitae dignissim augue."
    And I should see "Wizbam"
    And I should see "Image:"
    And I should see an "img" element
    And I should see "Test File Description"
    # Comments should show on the node view
    And I should see "Add new comment"
    And I should see "Your name"
    Then for "Subject" I enter "This is a comment subject"
    Then for "Comment" I enter "This is a comment and it is short"
    Then I press "Save"
    Then I should see "This is a comment subject"
    And I should see "This is a comment and it is short"
    And I should see "delete"

