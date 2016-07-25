Feature: Create boolean field test

  @api @content @javascript @longtext_summary @core
  Scenario: As an Administrator I want make sure the longtext with summary field is working
    Given I am logged in as a user with the "administrator" role
    When I visit "node/add/longtext-with-summary"
    Then I should see the text "Create Long Text with Summary"
    Then for "Title" I enter "Testing Long Text with Summary"
    # Note the lowercase 's' in 'summary' - Behat is case sensitive so this is important
    # Behat can 'click' a link id|title|alt|text
    Then I click "Edit summary"
    Then I should see "Hide Summary"
    And I should see the text "Text format"
    Then for "Summary" I enter "A short, concise summary"
    Then for "Long Text" I enter "Morbi mollis accumsan ante. Morbi vel ornare nisl, quis posuere justo. Cras fringilla eu tortor a tristique. Maecenas vitae commodo ipsum, vitae dignissim augue. Pellentesque ornare risus porta tellus ultrices, vel varius enim pellentesque. Fusce a convallis mi. Vestibulum non nulla eu orci semper porttitor eu non orci. Sed eu orci sed nunc varius dignissim. Nunc at consectetur eros. Maecenas est turpis, lobortis quis elementum id, porta mollis nulla. Donec ipsum diam, consectetur ac sem ut, finibus varius risus. Nulla faucibus ex nisi, eget gravida ex sollicitudin at. Ut porta semper erat et sollicitudin. Aenean at sapien lectus. Nulla ornare risus in nulla laoreet venenatis. Aenean auctor rhoncus sapien."
    Then I press "Save"
    Then I should see "Testing Long Text"
    Then I should see "A short, concise summary"
    # Here we ensure that only the summary is displayed by default, per the content type Display settings
    # If the full body field is displayed, there is an issue with our Display settings
    And I should not see "Morbi mollis accumsan ante. Morbi vel ornare nisl, quis posuere justo. Cras fringilla eu tortor a tristique. Maecenas vitae commodo ipsum, vitae dignissim augue. Pellentesque ornare risus porta tellus ultrices, vel varius enim pellentesque. Fusce a convallis mi. Vestibulum non nulla eu orci semper porttitor eu non orci. Sed eu orci sed nunc varius dignissim. Nunc at consectetur eros. Maecenas est turpis, lobortis quis elementum id, porta mollis nulla. Donec ipsum diam, consectetur ac sem ut, finibus varius risus. Nulla faucibus ex nisi, eget gravida ex sollicitudin at. Ut porta semper erat et sollicitudin. Aenean at sapien lectus. Nulla ornare risus in nulla laoreet venenatis. Aenean auctor rhoncus sapien."



