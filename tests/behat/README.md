# Web Starter Kit Behat Testing Platform

This is a quick-start setup for using Behat with Drupal projects built on [web-starter](https://github.com/forumone/web-starter/). It is intended to introduce the framework and lower the barrier to entry for developers.

This quick-start is not intended to be a comprehensive guide for learning Behat. There are many resources for learning about Behat generally, including this talk: https://www.youtube.com/watch?v=NsI8kPc3kBA

This setup includes the following components:

 * Behat
 * Drupal-Behat-Extension
 * PhantomJS

This is a **work in progress**: Please note that there are many pieces that can change over time.

## Verify Installation

Once Web Starter has been provisioned and you have created your Drupal site within it, you should be able to immediately run one of the default tests included in this quick-start:
```
$ vagrant ssh
$ cd /vagrant/tests/behat
$ /usr/local/bin/phantomjs --webdriver=8643 & # Start PhantomJS in the background on port 8643.
$ bin/behat features/TESTS/test.feature # Run one of our test Behat features.
```

You should see output including the scenario and steps passed.

(For the other default test included in this quick-start, see the Selenium instructions below.)

## Upgrading Latest Webstarter Behat Changes

In the event that you want to pull the latest Webstarter changes for Behat into an existing repo these files will be overridden
* features/bootstrap/F1ContentUtilityContext.php
* features/bootstrap/F1DrushUtilityContext.php
* features/bootstrap/F1FundamentalContext.php
* features/bootstrap/F1OGContext.php
* tests/behat/features/TESTS
* tests/behat/examples

The purpose of these custom context class files is to make different custom steps for .feature files and custom methods available to the F1 team, hence why we expect to overwrite them on occasion.

In order to avoid overriding changed files in existing projects, templates for all yml and Selenium json files are available as '.example' files in the 'examples' folder.

If you want to reintegrate upstream changes to these files you can choose to copy the '.example' files over and overwrite or manually merge in the changes.

## Usage

The behat.yml file comes with two default profiles, 'default' and 'selenium'.

The default profile uses PhantomJS to perform Behat tests via a headless browser. PhantomJS listens on port 8643:
```
wd_host:              'http://127.0.0.1:8643/wd/hub'
```

You must start PhantomJS before you are able to run any tests that require it:
```
/usr/local/bin/phantomjs --webdriver=8643 &
```

The Selenium profile uses the option java .jar file to run tests with the existing browsers on your local machine. Selenium listens on port 5555:
```
wd_host:              'http://127.0.0.1:5555/wd/hub'
```

See the Selenium 2 Information below on how to start Selenium Grid.

Using the following command to see the available steps that you can use to write tests:
```
bin/behat -dl
```

## Writing Tests

When writing tests, make sure to add your test .feature files to folders created under the tests/behat/features folder:

The purpose of adding a 'sub' folder is for the grunt-behat tasks, which are configured to look for all feature files under tests/behat/features/sub-folder/*

Example:
```
- tests
    - behat
        - features
            - CRUD
                - node_create.feature
            - VIEWS
                - view1.feature
            - PANELS
                - panel1.feature
                - panel2.feature

```

When writing tests within feature files make sure to include `@api` for making drush available in a feature:
```
@api
Scenario: I want to be able to show how to include Drush
```

The `@javascript` tag allows you to test with javascript-enabled drivers. Two of the javascript enabled drivers bundled with this testing framework are PhantomJS and Selenium Grid. The @javascript tag is a requirement for behat to run either PhantomJS and Selenium2. Both included profiles have Goutte enabled by default, which is the headless browser driver. Without the `@javascript` tag Goutte is selected to drive the tests.
```
@javascript
Scenario: I want to be able to show how to include Javascript
```

## Behat-Grunt Plugin

Web Starter includes the Behat-Grunt Plugin which can run multiple Behat tests and export the results to a JUNIT XML file.

Web Starter by default comes with six behat-grunt tasks:

 1. ``behatLocal`` which runs Behat jobs against PhantomJS. Called
 2. ``behatvmSelenium`` which runs Behat jobs against Selenium. Called from Host machine
 3. ``behatLocalSelenium`` which runs Behat jobs against Selenium. Called from VM machine
 4. ``behatJenkinsDev`` which runs Behat jobs against PhantomJS from our build server for a Dev site (see Jenkins Integration below)
 5. ``behatJenkinsStage`` which runs Behat jobs against PhantomJS from our build server for a Stage site (see Jenkins Integration below)

## Jenkins Integration

 1. Jenkins runs behat with the Behat-Grunt Plugin. Make sure that your Behat tests work wth the Behat-Grunt Plugin prior to pushing them up to Jenkins.
 2. Customize the behat.remote.yml file point to your respective dev and staging urls. (See the {{ placeholders }} in that file.)
 3. Clone a Jenkins job and disable the triggers to build based on git push, so that Behat only runs when you manually trigger it.
 4. Select 'Add a build step' -> 'Execute Shell'
  * Add the text to the Execute Shell textbox
 ```
 /usr/local/bin/phantomjs --webdriver=8643 &
 ```
 5. Select 'Add a build step' -> 'Execute Shell'
  * Add the text to the Execute Shell textbox
 ```
 cd tests/behat && /usr/local/bin/composer update && cd ../../ && grunt behatJenkinsDev && killall phantomjs
 ```

**Note** that the command `behatJenkinsDev` points to the dev environment and `behatJenkinsStage` points to the stage environment.

## Optional Selenium Functionality (Via Selenium Grid 2)

 1. Install Java for your Platform
  * Homebrew option: `brew cask install java` or https://java.com
 2. Mac
  * For users with chrome, OR firefox browsers the standard included nodeconfig.mac.json should work for you without any changes
 3. Windows
  * For users with chrome, OR firefox browsers the standard included nodeconfig.windows.json should work for you without any changes
 4. Linux
  * For users with chrome, OR firefox browsers the standard included nodeconfig.linux.json should work for you without any changes
 5. Use the following command to bring up the Selenium Hub on the Guest VM
 ```
 $ vagrant ssh
 $ cd /vagrant/tests/behat/
 $ java -jar selenium-server-standalone-{{ version }}.jar -role hub  -nodeConfig nodeconfig.server.json
 ```
 6. Use the following command to bring up the Selenium Hub on the Host
 ```
 $ cd tests/behat
 $ java -jar selenium-server-standalone-{{ version }}.jar -role node  -nodeConfig nodeconfig.mac.json
 ```
 7. You can now run behat with Selenium Grid 2 on the Guest VM which will request Browsers from the Host
 ```
 $ vagrant ssh
 $ cd /vagrant/tests/behat
 $ bin/behat features/test-js.feature  -p vm-selenium
 ```
 8. Chromedriver (optional). In order to run Chrome we need to start up the Chromedriver from the Host Machine
 ```
 $ cd tests/behat
 $ ./chromedriver
 ```

### Troubleshooting for Selenium:
1. Make sure that the hub/node can communicate with each other
    a. The way to check this is to make sure that both parts of selenium grid can communicate
    b. The nodeconfig.server.json is configured to be run from the vm
    c. The nodeconfig.{environment}.json is configured to be run from the host
    d. Make sure that the nodeconfig.{environment}.json has the correct host ip
2. Disable firewalls to make sure that communication isn't impedded

## Traversing Pages
Mink, the browser controller/emulator we use with Behat, has an Element API that allows for manipulating and interacting with page elements.  It contains the powerful TraversalbelElement method which – not surprisingly – able to traverse the DOM by html elements.  Two important classes of the TraversableElement method are the DocumentElement instance and the NodeElement class.  The former represents the `<html>` node of the page and the latter is used to represent any element inside the page.

The DocumentElement instance is accessible through the Session::getPage method:
```
$page = $session->getPage();
```
Elements have 2 main traversal methods: `ElementInterface::findAll` returns an array of NodeElement instances matching the provided selector inside the current element while `ElementInterface::find` returns the first match or null when there is none.

**DOM Manipulation**

The NodeElement class contains many methods for manipulating the DOM, a few examples include:
- `NodeElement::click` and `NodeElement::press` methods let you click the links and press the buttons on the page
- `NodeElement::check` and `NodeElement::uncheck` methods will check and uncheck a checkbox field 
- `NodeElement::focus` and `NodeElement::blur` allows you to give and remove focus on an element
-  **Drag’n’Drop** - allows you to drag and drop one element onto another:
    ```
    $drag = $page->find(…);
    $target = $page->find(…);

    $dragged->dragTo($target);
    ```

**Element Content and Text**

The `Element` class provides access to the content of the elements.
- `Element::getHtml` gets the inner HTML of the element, i.e. all the children of the element.
- `Element::getOutterHtml` gets the outter HTML of the element, i.e. including the element itself.
- `Element::getText` gets the text of the element.  This method will strip the tags and unprinted characters out of the response, including newlines.  So it’ll basically return the text that the user sees on the page.
 
**Regular Expression text matching**

Behat will look for a matching step definition by matching the text of the step against the regular expressions defined by each step definition.  In the following example:
```
Scenario: List 2 files in a directory with the -a option
  Given I am in a directory "test"
  And I have a file named "foo"
  And I have a file named ".bar"
  When I run "ls -a"
  Then I should get:
    """
    .
    ..
    .bar
    foo
    """
```
The first step's deffinition would look like: 
```
/**
 * @Given /^I am in a directory "([^"]*)"$/
 */
public function iAmInADirectory($dir)
{
    if (!file_exists($dir)) {
        mkdir($dir);
    }
    chdir($dir);
}
```
Where '@Given' is the keyword and the text after the keyword is the regular expression. All search patterns in the regular expression (e.g. `([^"]*)`) will become method arguments (`$dir`).

Below is a list of all the predifind steps that use regular expressions:

- Given `/^I` select `"([^"]*)" from "([^"]*)" chosen\.js select box$/`
- Given `/^I` select `"([^"]*)" from "([^"]*)" chosen\.js autoselect box$/`
- When `/^(?:|I )`press `"(?P<button>(?:[^"]|\\")*)"$/`
- When `/^(?:|I )`follow `"(?P<link>(?:[^"]|\\")*)"$/`
- When `/^(?:|I )`fill in `"(?P<field>(?:[^"]|\\")*)"` with `"(?P<value>(?:[^"]|\\")*)"$/`
- When `/^(?:|I )`fill in `"(?P<field>(?:[^"]|\\")*)"` with`:$/`
- When `/^(?:|I )`fill in `"(?P<value>(?:[^"]|\\")*)"` for `"(?P<field>(?:[^"]|\\")*)"$/`
- When `/^(?:|I )`fill in the `following:$/`
- When `/^(?:|I )`select `"(?P<option>(?:[^"]|\\")*)"` from `"(?P<select>(?:[^"]|\\")*)"$/`
- When `/^(?:|I )`additionally select `"(?P<option>(?:[^"]|\\")*)"` from `"(?P<select>(?:[^"]|\\")*)"$/`
- When `/^(?:|I )`check `"(?P<option>(?:[^"]|\\")*)"$/`
- When `/^(?:|I )`uncheck `"(?P<option>(?:[^"]|\\")*)"$/`
- When `/^(?:|I )`attach the file `"(?P<path>[^"]*)"` to `"(?P<field>(?:[^"]|\\")*)"$/`
- Then `/^(?:|I )`should be on `"(?P<page>[^"]+)"$/`
- Then `/^(?:|I )`should be on `(?:|the )homepage$/`
- Then `/^the (?i)url(?-i)` should match `(?P<pattern>"(?:[^"]|\\")*")$/`
- Then `/^the` response status code should be `(?P<code>\d+)$/`
- Then `/^the` response status code should not be `(?P<code>\d+)$/`
- Then `/^(?:|I )`should see `"(?P<text>(?:[^"]|\\")*)"$/`
- Then `/^(?:|I )`should not see `"(?P<text>(?:[^"]|\\")*)"$/`
- Then `/^(?:|I )`should see text matching `(?P<pattern>"(?:[^"]|\\")*")$/`
- Then `/^(?:|I )`should not see text matching `(?P<pattern>"(?:[^"]|\\")*")$/`
- Then `/^the` response should contain `"(?P<text>(?:[^"]|\\")*)"$/`
- Then `/^the` response should not contain `"(?P<text>(?:[^"]|\\")*)"$/`
- Then `/^(?:|I )`should see `"(?P<text>(?:[^"]|\\")*)"` in the `"(?P<element>[^"]*)" element$/`
- Then `/^(?:|I )`should not see `"(?P<text>(?:[^"]|\\")*)"` in the `"(?P<element>[^"]*)" element$/`
- Then `/^the "(?P<element>[^"]*)"` element should contain `"(?P<value>(?:[^"]|\\")*)"$/`
- Then `/^the "(?P<element>[^"]*)" `element should not contain `"(?P<value>(?:[^"]|\\")*)"$/`
- Then `/^(?:|I )`should see `an? "(?P<element>[^"]*)" element$/`
- Then `/^(?:|I )`should not see `an? "(?P<element>[^"]*)" element$/`
- Then `/^the "(?P<field>(?:[^"]|\\")*)"` field should contain `"(?P<value>(?:[^"]|\\")*)"$/`
- Then `/^the "(?P<field>(?:[^"]|\\")*)"` field should not contain `"(?P<value>(?:[^"]|\\")*)"$/`
- Then `/^(?:|I )`should see `(?P<num>\d+) "(?P<element>[^"]*)" elements?$/`
- Then `/^the "(?P<checkbox>(?:[^"]|\\")*)"` checkbox should be `checked$/`
- Then `/^the` checkbox `"(?P<checkbox>(?:[^"]|\\")*)" (?:is|should be) checked$/`
- Then `/^the "(?P<checkbox>(?:[^"]|\\")*)"` checkbox should not be `checked$/`
- Then `/^the` checkbox `"(?P<checkbox>(?:[^"]|\\")*)"` should `(?:be unchecked|not be checked)$/`
- Then `/^the` checkbox `"(?P<checkbox>(?:[^"]|\\")*)"` is `(?:unchecked|not checked)$/`
- Then `/^(?:|I )`should see `(?P<num>\d+) "(?P<element>[^"]*)" elements?$/`
- Then `/^the "(?P<checkbox>(?:[^"]|\\")*)"` checkbox should be `checked$/`
- Then `/^the` checkbox `"(?P<checkbox>(?:[^"]|\\")*)" (?:is|should be) checked$/`
- Then `/^the "(?P<checkbox>(?:[^"]|\\")*)"` checkbox should not be `checked$/`

A note about regular expressions and quoted strings:
- `(?P<option>(?:[^"]|\\")*)` does not support single quotes 

## Behat Context Files

In your folder you will notice this structure:

```
bootstrap
    F1ContentUtilityContext.php
    F1DrushUtilityContext.php
    F1FundamentalContext.php
    F1OGContext.php
    FeatureContext.php
```

These files are provided by the Behat Generator for making your life a little easier. Behat not only allows for writing .feature tests but also 
calling custom steps which in turn call custom methods within these files which can execute multiple steps or custom logic for running tests.
These files should be self-explanatory: F1ContentUtilityContext is for utility functions, F1DrushUtilityContext is for testing via drush, 
F1OGContext is for organic groups tests and the F1FundamentalContext context allows you to access all of the information 
about mocked content created through drupal, such as the nid, etc etc. The FeatureContext file is strictly for your project's 
custom methods which won't be overridden on a behat generator update.

### Behat Context Customization

Say that you are working on a function for your project that has been really helpful for doing a specific test. 
Depending on if the test is written in a non-specific way it might be a great candidate for other Drupal projects.
Here is the beauty of the F1 Behat program. You can create a Pull Request off of the Behat Generator repo to make sure that 
the function you wrote gets incorporated back into the Behat Generator for others to use. 

Example Function in F1ContentUtilityContext.php
```
function iVisitTheNode
```

If this function didn't exist in F1ContentUtilityContext.php, but you had created it in FeatureContext.php you would probably want to
share it with other folks via the Behat Generator repo. 

TODO: Provide link to repo, and an example PR


## Optional PhpStorm Integration

See: http://blog.jetbrains.com/phpstorm/2014/07/using-behat-in-phpstorm/

## XDEBUG Configuration with PhpStorm
 1. [Get the host machine's IP address from within the VM](http://stackoverflow.com/questions/19917148/tell-vagrant-the-ip-of-the-host-machine). Something like:
 ```
 netstat -rn | awk '/^0\.0\.0\.0/ { print $2}'
 ```
 2. On the VM export the following global variables before executing your behat test:
 ```
 export PHP_IDE_CONFIG="serverName=localhost" && export XDEBUG_CONFIG="idekey=PHPSTORM remote_host={{ host machine ip address }} remote_port=9000"
 ```
 3. Make sure that PhpStorm is listening for incoming Xdebug connection.
 4. The PhpStorm Remote Debug window should look like this: https://www.evernote.com/l/AFOIz6c6ZgZH95SMVORHE3PKqzXR3-fHl7MB/image.png
 5. The PhpStorm Remote Debug Server window should look like this: https://www.evernote.com/l/AFNq1AfZQjRJ_aWUZt3dsx4jCcjUoB0ldM4B/image.png
 6. The PhpStorm Xdebug settings window should look like this: https://www.evernote.com/l/AFNgeZ8wetNEGLbbN1UEhnPmRShsDhXpP9oB/image.png

## Optional PhantomJS Viewport Specifications
 1. Be aware that on line 53 in F1FundamentalContext.php there is a hardcoded value for the viewport size of the browser
 2. By default PhantomJS sets the viewport size to 480x800, however this causes Behat tests to fail when dom elements are not visible within that resolution size
    a. Example: If a menu collapses with smaller resolution than that item will not be viewable when PhantomJS attempts to view it with the default resolution of  480x800. By setting the resolution to 900x1440 we will be able to see the menu
 3. Ideally in the future we will be able to set the resolution through the profile. This is hardcoded for now until a upstream or patch fix in the future
 4. By all means alter these hardcoded values as you see fit for your project
    
## Gotchas

 1. Various Behat Drivers have specific browser functionality.
 2. The default Goutte driver does not allow for checking javascript/ajax functionality.
 3. PhantomJS as a headless driver does allow for ajax.
