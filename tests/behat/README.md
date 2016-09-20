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

 1. ``behatLocal`` which runs Behat jobs against PhantomJS
 2. ``behatvmSelenium`` [@todo addme]
 3. ``behatLocalSelenium`` which runs behat jobs against the Selenium grid system
 4. ``behatlocalPhantomjs``  [@todo addme]
 5. ``behatJenkinsDev`` which runs Behat jobs against PhantomJS from our build server for a Dev site (see Jenkins Integration below)
 6. ``behatJenkinsStage`` which runs Behat jobs against PhantomJS from our build server for a Stage site (see Jenkins Integration below)

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

## Optional Selenium Grid 2 Profile Features

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
2. Disable firewalls to make sure that communication isn't impedded


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

## Gotchas

 1. Various Behat Drivers have specific browser functionality.
 2. The default Goutte driver does not allow for checking javascript/ajax functionality.
 3. PhantomJS as a headless driver does allow for ajax.
