Feature: Create a Views test

  @api @content @javascript @view

  # This example makes use of a 'Scenario Outline', which allows us to test a set of values using placeholders
  # The string used for the "<placeholder>" can be anything, just like a normal variable. The placeholders must
  # be in the header row of the Gherkin table and the table must be preceded by 'Examples:'
  # http://docs.behat.org/en/v3.0/guides/1.gherkin.html

  Scenario: Create nodes with core fields
    Given "core_fields" content:
      | title                    | body          | boolean | text       | integer | term reference | status |
      | First node with fields   | Body field 1  | Yes     | California | 55      | Red            | 1      |
      | Second node with fields  | Body field 2  | No      | Montana    | 33      | Blue           | 1      |
      | Third node with fields   | Body field 3  | Yes     | New York   | 22      | Orange         | 1      |
      | Fourth node with fields  | Body field 4  | No      | Texas      | 11      | Green          | 1      |
      | Fifth node with fields   | Body field 5  | Yes     | Florida    | 99      | Blue           | 1      |
      | Sixth node with fields   | Body field 6  | No      | Kansas     | 88      | Green          | 1      |
      | Seventh node with fields | Body field 7  | Yes     | Maine      | 77      | Red            | 1      |
      | Eighth node with fields  | Body field 8  | No      | Minnesota  | 66      | Orange         | 1      |
      | Nineth node with fields  | Body field 9  | Yes     | Georgia    | 44      | Blue           | 1      |
      | Tenth node with fields   | Body field 10 | No      | Virginia   | 10      | Green          | 1      |

    When I visit "/behat-examples-core-fields-view"
    Then I should see "Behat"
    Then I should see the text "node with fields"
    And I should not see the text "Body field 6"