<?php


use Behat\Behat\Context\SnippetAcceptingContext;
use Behat\Behat\Context\Context;

/**
 * Defines application features from the specific context.
 */
class F1ContentUtilityContext extends F1FundamentalContext implements SnippetAcceptingContext, Context {


  public function __construct() {
  }
  
  /**
   * Handle Content Mocked content
   *
   */

  /**
   * @Then I iterate through nodes created and check that fields are correct
   */
  public function iIterateThroughNodesCreatedAndCheckThatFieldsAreCorrect() {
    foreach ($this->created_nodes as $node) {
      if (!empty($node) && !empty($node->nid)) {
        $this->visitPath('node/' . $node->nid . '/edit');
        foreach ($node as $key => $field) {
          // Check if the array value is an actual field
          if (strpos($key, 'field_') > -1) {
            $cardinality = 0;
            $field_final_value = $this->getFieldSelectedValues($key, $cardinality);
            foreach ($field['und'] as $value) {
              if (is_array($field_final_value)) {
                // Field Value Matches
                if (!empty($value['value']) && !in_array($value['value'], array_column($field_final_value, 0))) {
                  throw new \Exception(sprintf("No match found for field " . $key));
                  // Taxonomy References Matches
                }
                elseif (!empty($value['tid']) && !in_array($value['tid'], $field_final_value)) {
                  throw new \Exception(sprintf("No match found for field " . $key));
                }
              }
              else {
                if (!empty($value['value'])) {
                  $match = ($value['value'] == $field_final_value);
                }
                elseif (!empty($value['tid'])) {
                  $match = ($value['tid'] == $field_final_value);
                }

                $cardinality = +1;
                if (!$match) {
                  throw new \Exception(sprintf("No match found for field " . $key));
                }
              }
            }
          }
        }
      }
      else {
        throw new \Exception(sprintf("No node or nid found, make sure the profile is using the Drupal api_driver"));
      }
    }
  }

  /**
   * @Then I iterate through terms created and check that fields are correct
   */
  public function iIterateThroughTermsCreatedAndCheckThatFieldsAreCorrect() {
    $test = 1;
    foreach ($this->created_terms as $term) {
      if (!empty($term) && !empty($term->tid)) {
        $this->visitPath('taxonomy/term/' . $term->tid);
        $this->assertSession()->pageTextContains($term->name);
      }
      else {
        throw new \Exception(sprintf("No term or term id found, make sure the profile is using the Drupal api_driver"));
      }
    }
  }

  /**
   * @Then I iterate through users created and check that fields are correct
   */
  public function iIterateThroughUsersCreatedAndCheckThatFieldsAreCorrect() {
    foreach ($this->created_users as $user) {
      if (!empty($user) && !empty($user->uid)) {
        $this->visitPath('user/' . $user->uid);
        $this->assertSession()->pageTextContains($user->name);
      }
      else {
        throw new \Exception(sprintf("No user or user id found, make sure the profile is using the Drupal api_driver"));
      }
    }
  }

  public function getFieldSelectedValues($field, $cardinality) {
    //Try to grab a single cardinality field
    $field_value = $this->getSession()
      ->getPage()
      ->findById('edit-' . str_replace('_', '-', $field) . '-und');

    // If single cardinality field doesn't work try multiple
    if (empty($field_value) || !($field_value->getValue())) {
      //Try to grab a multiple cardinality field
      $field_value = $this->getSession()
        ->getPage()
        ->findById('edit-' . str_replace('_', '-', $field) . '-und-' . $cardinality . '-value');
    }

    // If single cardinality field doesn't work try multiple
    if (empty($field_value) || !($field_value->getValue())) {
      //Try to grab a multiple cardinality field
      $field_value = $this->getSession()
        ->getPage()
        ->findById('edit-' . str_replace('_', '-', $field) . '-und-' . $cardinality);
    }

    if (!empty($field_value) && ($field_value->getValue())) {
      //Return the single value
      return ($field_value->getValue());
    }

    // Multiple value
    $sub_value = array();
    $multi_match = FALSE;

    // If single cardinality field doesn't work try multiple checkboxes
    $field_value = $this->getSession()
      ->getPage()
      ->findById('edit-' . str_replace('_', '-', $field) . '-und');
    if (!empty($field_value)) {
      $field_value = $field_value->findAll('css', '.form-checkbox');
    }

    // If single cardinality field doesn't work try multiple radios
    if (empty($field_value)) {
      $field_value = $this->getSession()
        ->getPage()
        ->findById('edit-' . str_replace('_', '-', $field) . '-und');
      if (!empty($field_value)) {
        $field_value = $field_value->findAll('css', '.form-radio');
      }
    }

    if (count($field_value) > 1) {
      foreach ($field_value as $individual_final_value) {
        if (!(is_null(($individual_final_value->getValue()))) && $individual_final_value->isChecked() || ($individual_final_value->isSelected())) {
          $sub_value[] = array($individual_final_value->getValue());
        }
      }
    }

    if (!$sub_value) {
      throw new \Exception(sprintf("No match found for multiple cardinality field"));
    }
    else {
      //Return the multiple value
      return $sub_value;
    }
  }

  /**
   * Access Entities
   *
   */

  /**
   * @Then I visit the node :arg1
   */
  public function iVisitTheNode($index) {
    $found = FALSE;
    foreach ($this->created_nodes as $key => $node) {
      if ($key == ($index - 1)) {
        $found = TRUE;
      }
    }
    if (!($found)) {
      throw new \Exception(sprintf("Wasn't able to find the node, sucka"));
    }

  }

  /**
   *  Access Irregular Field Types
   *
   */

  /**
   * @Given /^I select "([^"]*)" from "([^"]*)" chosen\.js select box$/
   */
  public function iSelectFromChosenJsSelectBox($option, $select) {
    $select = $this->fixStepArgument($select);
    $option = $this->fixStepArgument($option);

    $page = $this->getSession()->getPage();
    $field = $page->findField($select, TRUE);

    if (NULL === $field) {
      throw new ElementNotFoundException($this->getSession()
        ->getDriver(), 'form field', 'id|name|label|value', $select);
    }

    $id = $field->getAttribute('id');
    $opt = $field->find('named', array('option', $option));
    $val = $opt->getValue();

    $javascript = "jQuery('#$id').val('$val');
                  jQuery('#$id').trigger('chosen:updated');
                  jQuery('#$id').trigger('change');";

    $this->getSession()->executeScript($javascript);
  }

  /**
   * @Given /^I select "([^"]*)" from "([^"]*)" chosen\.js autoselect box$/
   */
  public function iSelectFromChosenJAutoselectBox($option, $select) {
    $select = $this->fixStepArgument($select);
    $option = $this->fixStepArgument($option);
    $page = $this->getSession()->getPage();
    $field = $page->findField($select, TRUE);
    if (NULL === $field) {
      throw new ElementNotFoundException($this->getSession()
        ->getDriver(), 'form field', 'id|name|label|value', $select);
    }
    $id = $field->getAttribute('id');
    $javascript = "var select = jQuery('#$id > option:contains(\'$option\')').val();
                  jQuery('#$id').val(select).change().trigger('chosen:updated');";
    $this->getSession()->executeScript($javascript);
  }

  /**
   * @Then I should see the WYSIWYG buttons in the correct order
   */
  public function wysiwygButtonsInCorrectOrder() {
    // @todo fix after https://github.com/jcalderonzumba/gastonjs/issues/19
    $this->getSession()->wait(5000);
    $page = $this->getSession()->getPage();
    $expectations = [
      'Undo',
      'Redo',
      'Select All',
      'Cut',
      'Copy',
      'Paste',
      'Paste as plain text',
      'Paste from Word',
      'Find',
      'Remove Format',
      'Insert Special Character',
      '',
      'Paragraph Format',
      'Formatting Styles',
      'Bold',
      'Italic',
      'Insert/Remove Bulleted List',
      'Insert/Remove Numbered List',
      'Increase Indent',
      'Decrease Indent',
      'Superscript',
      'Subscript',
      'Block Quote',
      'Insert Horizontal Line',
      'Link',
      'Unlink',
      'Anchor',
      'Table',
      'IFrame',
      'Add files and images'
    ];
    $buttons = $page->findAll('css', 'span.cke_toolbox a');
    foreach ($buttons as $delta => $button) {
      Assert::assertArrayHasKey($delta, $expectations);
      Assert::assertEquals($expectations[$delta], $button->getAttribute('title'));
    }
  }

  /**
   * Misc
   *
   */

  /**
   * @Then I wait for text :text to :appear
   */
  public function iWaitForText($text, $appear = 'appear') {
    $this->waitForXpathNode(".//*[contains(normalize-space(string(text())), \"$text\")]", $appear == 'appear');
  }

  /**
   * @Then I wait for css element :element to :appear
   */
  public function iWaitForCssElement($element, $appear = 'appear') {
    $xpath = $this->getSession()
      ->getSelectorsHandler()
      ->selectorToXpath('css', $element);
    $this->waitForXpathNode($xpath, $appear == 'appear');
  }

  /**
   * Helper function; Execute a function until it return TRUE or timeouts.
   *
   * @param $fn
   *   A callable to invoke.
   * @param int $timeout
   *   The timeout period. Defaults to 10 seconds.
   *
   * @throws Exception
   */
  private function waitFor($fn, $timeout = 10000) {
    $start = microtime(TRUE);
    $end = $start + $timeout / 1000.0;
    while (microtime(TRUE) < $end) {
      if ($fn($this)) {
        return;
      }
    }
    throw new \Exception('waitFor timed out.');
  }

  /**
   * Wait for an element by its XPath to appear or disappear.
   *
   * @param string $xpath
   *   The XPath string.
   * @param bool $appear
   *   Determine if element should appear. Defaults to TRUE.
   *
   * @throws Exception
   */
  private function waitForXpathNode($xpath, $appear = TRUE) {
    $this->waitFor(function ($context) use ($xpath, $appear) {
      try {
        $nodes = $context->getSession()->getDriver()->find($xpath);
        if (count($nodes) > 0) {
          $visible = $nodes[0]->isVisible();
          return $appear ? $visible : !$visible;
        }
        return !$appear;
      } catch (WebDriverException $e) {
        if ($e->getCode() == WebDriverException::NO_SUCH_ELEMENT) {
          return !$appear;
        }
        throw $e;
      }
    });
  }

  /**
   * @Given /^I wait for (\d+) seconds$/
   */
  public function iWaitForSeconds($seconds) {
    $miliseconds = $seconds * 1000;
    $this->getSession()->wait($miliseconds);
  }
}