<?php


use Behat\Behat\Context\SnippetAcceptingContext;
use Behat\Behat\Context\Context;
use Behat\Behat\Hook\Scope\BeforeScenarioScope;
use Behat\Behat\Hook\Scope\AfterScenarioScope;
use Drupal\DrupalExtension\Hook\Scope\AfterNodeCreateScope;
use Drupal\DrupalExtension\Hook\Scope\AfterUserCreateScope;
use Drupal\DrupalExtension\Hook\Scope\AfterTermCreateScope;

/**
 * Defines application features from the specific context.
 */
class F1FundamentalContext extends FeatureContext implements SnippetAcceptingContext, Context {

  public $created_nodes;
  public $created_users;
  public $created_terms;


  public function __construct() {
  }

  /**
   * @AfterNodeCreate
   */
  public function grabNodeFields(AfterNodeCreateScope $scope) {
    $this->created_nodes[] = $scope->getEntity();
  }

  /**
   * @AfterUserCreate
   */
  public function grabUserFields(AfterUserCreateScope $scope) {
    $this->created_users[] = $scope->getEntity();
  }

  /**
   * @AfterTermCreate
   */
  public function grabTermFields(AfterTermCreateScope $scope) {
    $this->created_terms[] = $scope->getEntity();
  }

  /**
   * @BeforeScenario
   */
  public function alterMinkParameters(BeforeScenarioScope $scope) {
    $driver = $this->getMinkParameters();
    $session = $this->getMink()->getDefaultSessionName();
    if ($driver['browser_name'] == 'phantomjs' && $session != 'goutte') {
      $this->getSession()->getDriver()->resizeWindow(1440, 900);
    }

    $this->ogContext = $scope->getEnvironment()->getContext('F1ContentUtilityContext');
    $this->ogContext = $scope->getEnvironment()->getContext('F1DrushUtilityContext');
    $this->ogContext = $scope->getEnvironment()->getContext('F1OGContext');

  }

  /**
   * @AfterScenario
   */
  public function dumpInfoAfterFailedStep(AfterScenarioScope $event) {
    $driver = $this->getMinkParameters();
    $session = $this->getMink()->getDefaultSessionName();
    $profile = $this->getSession();
    if (!($event->getTestResult()->isPassed()) && $driver['browser_name'] == 'phantomjs' && $session != 'goutte') {
      $this->getSession()->getPage();
      $fileName = 'failed.html';
      $filePath = (ini_get('upload_tmp_dir') ? ini_get('upload_tmp_dir') : sys_get_temp_dir());
      file_put_contents($filePath . '/' . $fileName, $this->getSession()
        ->getPage()
        ->getHtml());
      $this->saveScreenshot('failed.png');
      print 'Screenshot at: ' . $filePath . DIRECTORY_SEPARATOR . $fileName;
    }
  }


}