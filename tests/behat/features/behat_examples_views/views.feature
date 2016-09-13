Feature: Create a core_fields test

  # This example makes use of a 'Scenario Outline', which allows us to test a set of values using placeholders
  # The string used for the "<placeholder>" can be anything, just like a normal variable. The placeholders must
  # be in the header row of the Gherkin table and the table must be preceded by 'Examples:'
  # http://docs.behat.org/en/v3.0/guides/1.gherkin.html

  Background:
    Given I am logged in as a user with the "administrator" role

    Given "Tags" terms:
      | name |
      | wizz |
      | bang |
      | zap  |
      | fizz |

    Given "Core Fields" content:
      | title         | body                                                                                        | field_boolean | field_float | field_integer | field_list | field_text | field_term_reference | field_image            |
      | Test One      | Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. | Yes           | 5.246       | 25            | Red        | Vestibulum | wizz                 | imagefield_2qsr26.gif  |
      | Test Two      | Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. | No            | 11.325      | 53            | Blue       | Donec      | bang                 | imagefield_4r3H2d.png  |
      | Test Three    | Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. | No            | 5.765       | 25            | Orange     | Curae      | zap                  | imagefield_6uCLh2.jpg  |
      | Test Four     | Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. | No            | 8.005       | 95            | Green      | Phasellus  | fizz                 | imagefield_cIoNGM.gif  |
      | Test Five     | Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. | Yes           | 23.115      | 56            | Violet     | Proin      | wizz                 | imagefield_Du53tF.jpeg |
      | Test Six      | Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. | Yes           | 12.246      | 85            | Red        | Vestibulum | wizz                 | imagefield_MqZSGy.jpg  |
      | Test Seven    | Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. | No            | 65.325      | 93            | Blue       | Donec      | bang                 | imagefield_neyuct.jpg  |
      | Test Eight    | Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. | No            | 34.765      | 35            | Orange     | Curae      | zap                  | imagefield_PDh8et.jpeg |
      | Test Nine     | Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. | Yes           | 87.405      | 75            | Green      | Phasellus  | fizz                 | imagefield_R7pSrl.gif  |
      | Test Ten      | Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. | Yes           | 26.165      | 6             | Blue       | Proin      | wizz                 | imagefield_RsKHqB.gif  |
      | Test Eleven   | Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. | Yes           | 10.846      | 5             | Orange     | Vestibulum | wizz                 | imagefield_S4q9ZJ.jpg  |
      | Test Twelve   | Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. | No            | 19.925      | 13            | Red        | Donec      | bang                 | imagefield_t8z2AV.jpg  |
      | Test Thirteen | Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. | Yes           | 48.065      | 45            | Green      | Curae      | zap                  | imagefield_tW12T0.jpg  |
      | Test Fourteen | Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. | No            | 76.165      | 99            | Green      | Phasellus  | fizz                 | imagefield_XeozFa.gif  |
      | Test Fifteen  | Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. | Yes           | 63.915      | 12            | Violet     | Proin      | wizz                 | imagefield_y8nGiU.jpeg |

  @api @content @javascript @views
  Scenario Outline: Look for the values in the view
    #Go the view page
    When I am on "behat-examples-core-fields-view"
    And I should see "<title>"
    And I should see "<body>"
    And I should see "<field_boolean>"
    And I should see "<field_float>"
    And I should see "<field_integer>"
    And I should see "<field_text>"
    And I should see "<field_term_reference>"

    Examples:
      | title         | body                                                                                        | field_boolean | field_float | field_integer | field_list | field_text | field_term_reference | field_image           |
      | Test Four     | Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. | No            | 8.01        | 95            | Green      | Phasellus  | fizz                 | imagefield_cIoNGM.gif |
      | Test Six      | Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. | Yes           | 12.25       | 85            | Red        | Vestibulum | wizz                 | imagefield_MqZSGy.jpg |
      | Test Seven    | Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. | No            | 65.33       | 93            | Blue       | Donec      | bang                 | imagefield_neyuct.jpg |
      | Test Nine     | Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. | Yes           | 87.41       | 75            | Green      | Phasellus  | fizz                 | imagefield_R7pSrl.gif |
      | Test Fourteen | Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. | No            | 76.17       | 99            | Green      | Phasellus  | fizz                 | imagefield_XeozFa.gif |

#  When I click "sort by Text"
#  When I click "sort by Title"
    When for "search" I enter "Curae"
    And I press "Apply"
    Then I should not see "Test One"

    When for "term" I enter "zap"
    And I press "Apply"
    Then I should not see "Test Twelve"
    But I should see "Test Thirteen"

