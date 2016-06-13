Feature: I want to test the 'register' page

  @javascript @anon
  Scenario: As an anonymous user I want to make sure that the register page works properly
    Given I visit "/user/register"
    Then I should see text matching "PREVIEW LIMITED SITE."
    Then I should see the link "Access as a Guest"
    Then I should see text matching "INNOVATIONS"
    Then I should see text matching "AVAILABLE"
    Then I should see text matching "Forgot your Password"
    Then I should see text matching "By creating an account, you agree to our terms and conditions."
    Then I should see text matching "Join to Access the Full Site and Resources- It's FREE"
