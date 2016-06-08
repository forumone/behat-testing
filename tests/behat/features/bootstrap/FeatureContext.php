<?php

use Behat\Behat\Context\ClosuredContextInterface,
  Behat\Behat\Context\TranslatedContextInterface,
  Behat\Behat\Exception\PendingException;
use Behat\Gherkin\Node\PyStringNode,
  Behat\Gherkin\Node\TableNode;
use Behat\MinkExtension\Context\MinkContext;
use Behat\Behat\Context\Step\Given;
use Behat\Behat\Context\Step\When;
use Behat\Behat\Context\Step\Then;
use Behat\Behat\Context\BehatContext;
use Sanpi\Behatch\Context\BehatchContext;
use Behat\Mink\Exception\ElementNotFoundException,
  Behat\Behat\Event\StepEvent;



/**
 * Features context.
 */
class FeatureContext extends Drupal\DrupalExtension\Context\DrupalContext {

  private $currentUser;

  public function spin($lambda) {
    while (TRUE) {
      try {
        if ($lambda($this)) {
          return TRUE;
        }
      } catch (Exception $e) {
        // do nothing
      }

      sleep(1);
    }
  }

  /**
   * Initializes context.
   * Every scenario gets it's own context object.
   *
   * @param array $pg_parameter_status () context parameters (set them up through behat.yml)
   */
  public function __construct(array $parameters) {
    //NestedSubContext Behatch Library
//    $this->useContext('behatch', new BehatchContext($parameters));

  }

//  TODO: Figure a smarter place for this @@@@!!!!! For use with local setups only !!!!!@@@@
//  /**
//   * @AfterStep
//   */
//  public function dumpInfoAfterFailedStep(StepEvent $event) {
//
//    if ($event->getResult() === StepEvent::FAILED)
//    {
//      $this->getSession()->getPage();
//      $filename =  'failed.html';
//      $filepath = (ini_get('upload_tmp_dir') ? ini_get('upload_tmp_dir') : sys_get_temp_dir());
//      file_put_contents($filepath . '/' . $filename, $this->getSession()->getPage()->getHtml());
//      $this->saveScreenshot('failed.png');
//      exec('open ' . sys_get_temp_dir() . '/failed.html');
//      exec('open ' . sys_get_temp_dir() . '/failed.png');
//      $this->iPutABreakpoint();
//    }
//  }

//  /*
//   * @BeforeSuite
//   */
//  public function xdebug_start() {
//    $this->getSession()
//      ->executeScript('javascript:(/**%20%40version%200.5.2%20*/function()%20%7Bdocument.cookie%3D%27XDEBUG_SESSION%3D%27%2B%27PHPSTORM%27%2B%27%3Bpath%3D/%3B%27%3B%7D)()');
//  }
//
//  /*
//   * @AfterSuite
//   */
//  public function xdebug_stop() {
//    $this->getSession()
//      ->executeScript('javascript:(/** %40version 0.5.2 */function() %7Bdocument.cookie%3D%27XDEBUG_SESSION%3D%27%2B%27%27%2B%27%3Bexpires%3DMon, 05 Jul 2000 00:00:00 GMT%3Bpath%3D/%3B%27%3B%7D)()');
//  }


  /**
   * Pauses the scenario until the user presses a key. Useful when debugging a scenario.
   *
   * @Then /^(?:|I )put a breakpoint$/
   */
  public function iPutABreakpoint() {
    fwrite(STDOUT, "\033[s    \033[93m[Breakpoint] Press \033[1;93m[RETURN]\033[0;93m to continue...\033[0m");
    while (fgets(STDIN, 1024) == '') {
    }
    fwrite(STDOUT, "\033[u");
    return;
  }

  /**
   * @Then /^I test each of the features to see if they can be reverted$/
   */
  public function iTestEachOfTheFeaturesToSeeIfTheyCanBeReverted() {
    $feature_listing_payload = $this->readDrushOutput();
    if (empty($feature_listing_payload)) {
      throw new pendingException('This scenario has no Drush command output.');
    }
    else {
      $feature_listing_payload = json_decode($feature_listing_payload, TRUE);
      foreach ($feature_listing_payload as $feature) {
        if (!empty($feature['version']) && $feature['version'] == 'Overridden') {
          $command = 'fr';
          $output = $this->getDriver('Drush')
            ->$command($feature['feature'], '--force', '--format=json', 'force_yes');
          //Get only the JSON Output
          preg_match('~\{(?:[^{}]|(?R))*\}~', $output, $json_output, PREG_OFFSET_CAPTURE, 3);
          if (!empty($json_output)) {
            $json = json_decode($json_output[0][0]);
            if ((empty($json->SUCCESS) || ($json->SUCCESS != $feature['feature']))) {
              throw new \Exception(sprintf("The last feature revert output did not contain '%s' although it should have", $feature['feature']));
            }
          }
          else {
            throw new \Exception(sprintf("The last feature revert output did not contain '%s' although it should have", $feature['feature']));
          }
        }
      }
    }
  }

  /**
   * @Then /^I test that each of the updates worked correctly$/
   */
  public function iTestThatEachOfTheUpdatesWorkedCorrectly() {
    $updb_payload = $this->readDrushOutput();
    //Grab only the JSON by looking for the newline prior to the cache clear/admin role reset
    $updb_payload = json_decode(strstr($updb_payload, "\n", TRUE), TRUE);

    // Only trigger on Failed updates. Not when there are no updates or no output
    if (!empty($updb_payload) && !$updb_payload['success']) {
      $failed_updates = array();
      foreach ($updb_payload['results'] as $payload) {
        $failed_updates[] = $payload;
      }
      throw new \Exception(sprintf("Drush updb returned an error while attempting the following updates: '%s'", implode(', ', $failed_updates)));

    }
  }

  /**
   * Wait for AJAX to finish.
   *
   * @Given /^I wait for AJAX$/
   */
  public function iWaitForAjax() {
    $this->getSession()
      ->wait(10000, '(typeof(jQuery)=="undefined" || (0 === jQuery.active && 0 === jQuery(\':animated\').length))');
  }

  /**
   * @When /^I select the first autocomplete option for "([^"]*)" on the "([^"]*)" field$/
   */
  public function iSelectFirstAutocomplete($prefix, $identifier) {
    $session = $this->getSession();
    $page = $session->getPage();
    $element = $page->findField($identifier);
    if (empty($element)) {
      throw new \Exception(sprintf('We couldn\'t find "%s" on the page', $identifier));
    }
    $page->fillField($identifier, $prefix);

    $xpath = $element->getXpath();
    $driver = $session->getDriver();

    // autocomplete.js uses key down/up events directly.

    // Press the backspace key.
    $driver->keyDown($xpath, 8);
    $driver->keyUp($xpath, 8);

    // Retype the last character.
    $chars = str_split($prefix);
    $last_char = array_pop($chars);
    $driver->keyDown($xpath, $last_char);
    $driver->keyUp($xpath, $last_char);

    // Wait for AJAX to finish.
    $this->iWaitForAJAX();

    // And make sure the autocomplete is showing.
    $this->getSession()
      ->wait(5000, 'jQuery("#autocomplete").show().length > 0');

    // And wait for 1 second just to be sure.
    sleep(1);

    // Press the down arrow to select the first option.
    $driver->keyDown($xpath, 40);
    $driver->keyUp($xpath, 40);

    // Press the Enter key to confirm selection, copying the value into the field.
    $driver->keyDown($xpath, 13);
    $driver->keyUp($xpath, 13);

    // Wait for AJAX to finish.
    $this->iWaitForAJAX();
  }


  /**
   * @Then /^I wait for text "([^"]*)" to appear$/
   */
  public function iWaitForTextToAppear($arg1) {

    $this->spin(function (FeatureContext $context) use ($arg1) {
      try {
        $context->assertPageContainsText($arg1);
        return TRUE;
      } catch (ResponseTextException $e) {
        // NOOP
      }
      return FALSE;
    });
  }

  /**
   * @Then /^I show last Drush response$/
   */
  public function iShowLastDrushResponse() {
    error_log(print_r($this->readDrushOutput()));
  }

  /**
   * @When /^I fill in CKEditor field "([^"]*)" with "([^"]*)"$/
   */
  public function iFillInCkeditorFieldWith($id, $text) {
    // Enter value for CKEDITOR field using id
    $javascript = 'CKEDITOR.instances["' . $id . '"].focus();
     var range = CKEDITOR.instances["' . $id . '"].setData("' . $text . '");
     CKEDITOR.instances["' . $id . '"].insertText("' . $text . '");';
    $this->getSession()->executeScript($javascript);
  }

  /**
   * @When /^I check that my local file "([^"]*)" exists$/
   */
  public function iCheckThatMyLocalFileExists($arg1) {
    if (!file_exists('files/' . $arg1)) {
      throw new \Exception("File does not exist");
    }
  }

  /**
   * @When /^I attach the remote file "([^"]*)" to "([^"]*)"$/
   */
  public function iAttachTheRemoteFileTo($arg1, $arg2) {

//    $localFile = $arg1;
//    $tempZip = tempnam('', 'WebDriverZip');
//    $zip = new \ZipArchive();
//    $zip->open($tempZip, \ZipArchive::CREATE);
//    $zip->addFile($localFile, basename($localFile));
//    $zip->close();

    $remotePath = $this->getSession()
      ->getDriver()
      ->getWebDriverSession()
      ->file([
        'file' => base64_encode(file_get_contents($arg1))
      ]);

    $this->attachFileToField($arg2, $remotePath);

//    unlink($tempZip);

//    $field = $this->fixStepArgument($arg2);
//
//    if ($this->getMinkParameter('files_path')) {
//      $fullPath = rtrim(realpath($this->getMinkParameter('files_path')), DIRECTORY_SEPARATOR).DIRECTORY_SEPARATOR.$path;
//      if (is_file($fullPath)) {
//        $path = $fullPath;
//      }
//    }
//
//    $this->getSession()->getPage()->attachFileToField($field, $path);
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
              ->visit($this->locatePath('search?search_api_views_fulltext=' . preg_replace("/[^a-z0-9_\-\s]+/i", " ", (mb_ereg_replace('\s+?(\S+)?$', '', substr($data[7], 0, 128))))));

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
        ->visit($this->locatePath('admin/config/workflow/rules/reaction/manage/' . $rule . '/delete'));
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
    $field = $page->findField($select, true);

    if (null === $field) {
      throw new ElementNotFoundException($this->getSession()->getDriver(), 'form field', 'id|name|label|value', $select);
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
    $field = $page->findField($select, true);
    if (null === $field) {
      throw new ElementNotFoundException($this->getSession()->getDriver(), 'form field', 'id|name|label|value', $select);
    }
    $id = $field->getAttribute('id');
    $javascript = "var select = jQuery('#$id > option:contains(\'$option\')').val();
                  jQuery('#$id').val(select).change().trigger('chosen:updated');";
    $this->getSession()->executeScript($javascript);
  }



}
