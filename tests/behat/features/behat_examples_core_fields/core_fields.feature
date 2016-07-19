Feature: Create a core_fields test

  @api @content @javascript @core_fields

  # This example makes use of a 'Scenario Outline', which allows us to test a set of values using placeholders
  # The string used for the "<placeholder>" can be anything, just like a normal variable. The placeholders must
  # be in the header row of the Gherkin table and the table must be preceded by 'Examples:'
  # http://docs.behat.org/en/v3.0/guides/1.gherkin.html

  Scenario Outline: As an Administrator I want make sure all core fields are working
    Given I am logged in as a user with the "administrator" role
    When I visit "node/add/core-fields"
    Given I enter "<value>" for "<field>"

    Examples:
      | field          | value                                                                                                 |
      | Title          | Testing Core Fields                                                                                   |
      | Body           | Vestibulum rutrum, mi nec elementum vehicula, eros quam gravida nisl, id fringilla neque ante vel mi. |
      | Boolean        | Yes                                                                                                   |
      | Integer        | 999                                                                                                   |
      | List           | Red                                                                                                   |
      | Float          | 444.5678                                                                                              |
      | Term Reference | Wizbang                                                                                               |

    And I press "Save"

    Then I should see "<result>"

    Examples:
      | result                                                                                               |
      | Testing Core Fields                                                                                   |
      | Vestibulum rutrum, mi nec elementum vehicula, eros quam gravida nisl, id fringilla neque ante vel mi. |
      | Yes                                                                                                   |
      | 999                                                                                                   |
      | Red                                                                                                   |
      | 444.5678                                                                                              |
      | Wizbang                                                                                               |

