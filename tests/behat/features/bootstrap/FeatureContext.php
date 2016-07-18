<?php

use Behat\Behat\Tester\Exception\PendingException;
use Behat\MinkExtension\Context\RawMinkContext;
use Behat\MinkExtension\Context\MinkContext;
use Drupal\DrupalExtension\Context\RawDrupalContext;
use Drupal\DrupalExtension\Context\DrupalContext;
use Behat\Behat\Context\SnippetAcceptingContext;
use Behat\Gherkin\Node\PyStringNode;
use Behat\Gherkin\Node\TableNode;
use Behat\Behat\Hook\Scope\AfterScenarioScope;

/**
 * Defines application features from the specific context.
 */
class FeatureContext extends RawDrupalContext implements SnippetAcceptingContext {

  /**
   * Initializes context.
   */
  public function __construct() {
  }

  /**
   * Fix the screen resolution so that all browser drivers get a correct 'Desktop' view
   * @TODO Allow a custom profile window size
   *
   *
   * @BeforeScenario
   */
  public function beforeScenario() {
    $driver = $this->getMinkParameters();
    if ($driver['browser_name'] == 'phantomjs') {
      $this->getSession()->getDriver()->resizeWindow(1440, 900);
    }
  }

  //  TODO: Figure a smarter place for this @@@@!!!!! For use with local setups only !!!!!@@@@
  /**
   * @AfterScenario
   */
  public function dumpInfoAfterFailedStep(AfterScenarioScope $event) {
    $driver = $this->getMinkParameters();
    if (!($event->getTestResult()->isPassed()) && $driver['browser_name'] == 'phantomjs') {
      $this->getSession()->getPage();
      $filename = 'failed.html';
      $filepath = (ini_get('upload_tmp_dir') ? ini_get('upload_tmp_dir') : sys_get_temp_dir());
      file_put_contents($filepath . '/' . $filename, $this->getSession()
        ->getPage()
        ->getHtml());
      $this->saveScreenshot('failed.png');
      exec('open ' . sys_get_temp_dir() . '/failed.html');
      exec('open ' . sys_get_temp_dir() . '/failed.png');
//      $this->iPutABreakpoint();
    }
  }

  /**
   * @Then /^I check the data import for accuracy with the import file "([^"]*)"$/
   */
  public function iCheckTheDataImportForAccuracyWithTheImportFile($arg1) {

    error_log($this->getMinkParameter('files_path'));

    if (!file_exists($this->getMinkParameter('files_path') . $arg1)) {
      throw new \Exception("File does not exist");
    }
    else {
      $row = 1;
      $search_mismatch = array();
      $body_mismatch = array();
      if (($handle = fopen($this->getMinkParameter('files_path') . $arg1, "r")) !== FALSE) {
        while (($data = fgetcsv($handle, 0, ",", '"')) !== FALSE) {
          error_log('Row: ' . $row . ' done. ' . $data[7]);
          $row++;
          if ($row > 2 && isset($data[7]) && !empty($data[7]) && isset($data[8]) && !empty($data[8]) && isset($data[1]) && ($data[1] == 'Grand Challenges' || $data[1] == 'Grand Challenges in Global Health' || $data[1] == 'Grand Challenges Explorations')) {
            // Replace non alphanumeric characters and limit the full text to 128 characters due to search constraints
            $this->getSession()
              ->visitPath($this->locatePath('search?search_api_views_fulltext=' . preg_replace("/[^a-z0-9_\-\s]+/i", " ", (mb_ereg_replace('\s+?(\S+)?$', '', substr($data[7], 0, 128))))));

            // Trim text off end of title
            $link = $this->fixStepArgument(rtrim($data[7]));

            // Attempt to find link
            $link = $this->getSession()->getPage()->findLink($link);

            // Catch links that are not found and save for later display
            if (NULL === $link) {
              $search_mismatch[$row] = array(
                'title' => $data[7],
                'original_title' => $data[7],
                'searched_url' => $this->fixStepArgument($data[7]),
                'url' => $this->getSession()->getCurrentUrl()
              );
            }
            else {
              $link->click();

              // Replace tabs and double spaces with single spaces
              $data[8] = mb_ereg_replace(" {2,}|[\t]", ' ', $data[8]);

              $actual = $this->getSession()->getPage()->getText();

              // Check body text
              $text_match = preg_match($this->fixStepArgument("/" . preg_quote($data[8], '/') . "/"), $actual);

              // Catch body text that are not found and save for later display
              if (!$text_match) {
                $body_mismatch[$row] = array(
                  'title' => $data[7],
                  'searched_text' => $this->fixStepArgument("/" . preg_quote($data[8], '/') . "/"),
                  'url' => $this->getSession()->getCurrentUrl()
                );
              }
            }
          }
        }
        if (!empty($search_mismatch)) {
          error_log('Search Mismatch');
          error_log(print_r($search_mismatch));
        }

        if (!empty($search_mismatch)) {
          error_log('Body Mismatch');
          error_log(print_r($body_mismatch));
        }

        fclose($handle);
      }
    }
  }


  /**
   * @Then /^I delete the rule my user created$/
   */
  public function iDeleteTheRuleMyUserCreated() {
    $sql = ("sqlq \"Select id from rules_config where name = 'rules_test_rule'\"");
    $rule = trim($this->getDriver('drush')->$sql());
    if (!empty($rule)) {
      $this->getSession()
        ->visitPath($this->locatePath('admin/config/workflow/rules/reaction/manage/' . $rule . '/delete'));
      $button = $this->fixStepArgument('Confirm');
      $this->getSession()->getPage()->pressButton($button);
    }
  }


  /**
   * @Given /^I wait for (\d+) seconds$/
   */
  public function iWaitForSeconds($seconds) {
    $miliseconds = $seconds * 1000;
    $this->getSession()->wait($miliseconds);
  }


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
   * @Then /^I will visit the user edit screen and apply a new role to each user$/
   */
  public function iWillVisitTheUserEditScreenAndApplyANewRoleToEachUser() {
    $test = 1;
    foreach ($this->users as $user) {
      $command = 'user-information';
      $output = $this->getDriver('Drush')
        ->$command($user->mail, '--format=json');
      //Get only the JSON Output
      preg_match('~\{(?:[^{}]|(?R))*\}~', $output, $json_output, PREG_OFFSET_CAPTURE, 3);
      if (!empty($json_output)) {
        $json = json_decode($json_output[0][0]);
        if (empty($json) || empty($json->uid)) {
          throw new \Exception(sprintf("Unable to retrieve information on user via drush"));
        }
      }
      $this->visitPath('user/' . $json->uid . '/edit');
      $this->fillField('First Name', 'Test First');
      $this->fillField('Last Name', 'Test Last');
      $this->checkOption('Intern');
      $this->pressButton('Save');
      $this->assertSession()->pageTextContains('The changes have been saved.');
      $this->visitPath('user/' . $json->uid . '/edit');
      $this->assertSession()->checkboxChecked('Intern');
    }
  }

  /**
   * @Given /^I retrieve "([^"]*)" content to search on the site$/
   */
  public function iRetrieveContentToSearchOnTheSite($type) {
    $command = 'f1-search';
    $output = $this->getDriver('Drush')
      ->$command($type);

    //Get only the JSON Output
    if (!empty($output)) {
      $output = json_decode($output);
      if (empty($output)) {
        throw new \Exception(sprintf("Unable to retrieve search information via drush"));
      }
      else {
        $this->search = $output;
      }
    }
  }

  /**
   * @Then /^I check that the content is "([^"]*)" on the search page$/
   */
  public function iCheckThatTheContentIsOnTheSearchPage($available) {

    if ($available == 'available') {
      if (empty($this->search)) {
        throw new \Exception(sprintf("Unable to retrieve search information via drush"));
      }
      foreach ($this->search as $item) {
        $this->visitPath('search/' . $item);
        $this->assertSession()
          ->pageTextNotContains('Your search yielded no results.');
        $this->assertSession()
          ->pageTextNotContains('Check if your spelling is correct.');
        $this->assertSession()
          ->pageTextNotContains('Remove quotes around phrases to search for each word individually.');
        $this->assertSession()
          ->pageTextNotContains('Use fewer keywords to increase the number of results.');
      }
    }
    else {
//      if (empty(‌‌$this->{"*Drupal\DrupalExtension\Context\RawDrupalContext*drupal"}->environment->contexts['Drupal\DrupalExtension\Context\DrupalContext']->nodes)) {
//
      if (TRUE) {
        throw new \Exception(sprintf("Unable to retrieve search information via drush"));
      }
      foreach ($this->search as $item) {
        $this->visitPath('search/' . $item);
        $this->assertSession()
          ->pageTextNotContains('Your search yielded no results.');
        $this->assertSession()
          ->pageTextNotContains('Check if your spelling is correct.');
        $this->assertSession()
          ->pageTextNotContains('Remove quotes around phrases to search for each word individually.');
        $this->assertSession()
          ->pageTextNotContains('Use fewer keywords to increase the number of results.');
      }
    }
  }

  /**
   * @Then I visit the user edit screen and apply a social media url to each user
   */
  public function iVisitTheUserEditScreenAndApplyASocialMediaUrlToEachUser() {
    $test = 1;
  }

}
