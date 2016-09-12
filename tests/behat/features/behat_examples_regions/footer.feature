Feature: Create a Views test

  @api @content @view @regions @footer-region

  Scenario: Check the footer region for 'Powered by Drupal'
    Given I am at "/"
    #This step assumes that you have an out-of-the-box Drupal site with the 'Powered by Drupal' block assigned to the footer
    Then I should see "Powered by Drupal" in the "footer" region