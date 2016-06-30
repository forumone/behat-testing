Feature: Basic Behat 3 Node Create Feature

  @api @content @javascript @creation
  Scenario: As an Administration user I want two test page content
    Given "Behat Test Content Type" content:
      | title    | field_test_boolean |  field_test_decimal | field_test_integer | field_test_float_list | field_test_integer_list | field_test_text_list | field_test_term_reference | field_test_text |
      | Test One | 1                  |  .2                 | 2                  | .22, .55              | 1, 2, 3                 | black                | bald, sense               | white           |
      | Test Two | 0                  |  .5                 | 5                  | .333, .75             | 4, 5, 6                 | white                | ran, fire                 | black           |
    Given I break