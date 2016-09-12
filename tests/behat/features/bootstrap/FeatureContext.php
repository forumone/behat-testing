<?php

use Behat\Behat\Tester\Exception\PendingException;
use Behat\MinkExtension\Context\RawMinkContext;
use Behat\MinkExtension\Context\MinkContext;
use Drupal\DrupalExtension\Context\RawDrupalContext;
use Drupal\DrupalExtension\Context\DrupalContext;
use Behat\Behat\Context\SnippetAcceptingContext;
use Behat\Gherkin\Node\PyStringNode;
use Behat\Gherkin\Node\TableNode;
use Behat\Behat\Context\Context;
use Behat\Testwork\Hook\Scope\BeforeSuiteScope;
use Behat\Behat\Hook\Scope\BeforeScenarioScope;
use Behat\Behat\Hook\Scope\AfterScenarioScope;
use Drupal\DrupalExtension\Hook\Scope\AfterNodeCreateScope;
use Drupal\DrupalExtension\Hook\Scope\AfterUserCreateScope;
use Drupal\DrupalExtension\Hook\Scope\AfterTermCreateScope;

/**
 * Defines application features from the specific context.
 */
class FeatureContext extends RawDrupalContext implements SnippetAcceptingContext, Context {

  /**
   * Initializes context.
   */
  public function __construct() {
  }

  /**
   * @When /^I hover over the element "([^"]*)"$/
   */
  public function iHoverOverTheElement($locator)
  {
    $session = $this->getSession(); // get the mink session
    $element = $session->getPage()->find('css', $locator); // runs the actual query and returns the element

    // errors must not pass silently
    if (null === $element) {
      throw new \InvalidArgumentException(sprintf('Could not evaluate CSS selector: "%s"', $locator));
    }

    // ok, let's hover it
    $element->mouseOver();
  }



}
