Feature: Create boolean field test

  @api @content @javascript @comments @core
  Scenario: As an Administrator I want make sure the longtext value field is working
    Given I am logged in as a user with the "administrator" role
    When I visit "node/add/longtext"
    Then I should see the text "Create Long Text Field"
    Then for "Title" I enter "Testing Long Text"
    Then I should see the text "Text format"
    Then for "Long Text" I enter "Morbi mollis accumsan ante. Morbi vel ornare nisl, quis posuere justo. Cras fringilla eu tortor a tristique. Maecenas vitae commodo ipsum, vitae dignissim augue. Pellentesque ornare risus porta tellus ultrices, vel varius enim pellentesque. Fusce a convallis mi. Vestibulum non nulla eu orci semper porttitor eu non orci. Sed eu orci sed nunc varius dignissim. Nunc at consectetur eros. Maecenas est turpis, lobortis quis elementum id, porta mollis nulla. Donec ipsum diam, consectetur ac sem ut, finibus varius risus. Nulla faucibus ex nisi, eget gravida ex sollicitudin at. Ut porta semper erat et sollicitudin. Aenean at sapien lectus. Nulla ornare risus in nulla laoreet venenatis. Aenean auctor rhoncus sapien."

    Then I press "Save"
    Then I should see "Testing Long Text"
    And I should see "Morbi mollis accumsan ante. Morbi vel ornare nisl, quis posuere justo. Cras fringilla eu tortor a tristique. Maecenas vitae commodo ipsum, vitae dignissim augue. Pellentesque ornare risus porta tellus ultrices, vel varius enim pellentesque. Fusce a convallis mi. Vestibulum non nulla eu orci semper porttitor eu non orci. Sed eu orci sed nunc varius dignissim. Nunc at consectetur eros. Maecenas est turpis, lobortis quis elementum id, porta mollis nulla. Donec ipsum diam, consectetur ac sem ut, finibus varius risus. Nulla faucibus ex nisi, eget gravida ex sollicitudin at. Ut porta semper erat et sollicitudin. Aenean at sapien lectus. Nulla ornare risus in nulla laoreet venenatis. Aenean auctor rhoncus sapien."
    And I should see "Add new comment"
    And I should see "Your name"
    Then for "Subject" I enter "This is a comment subject"
    Then for "Comment" I enter "This is a comment and it is short"
    Then I press "Save"
    Then I should see "This is a comment subject"
    And I should see "This is a comment and it is short"
    And I should see "delete"







