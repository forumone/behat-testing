module.exports = function(grunt) {

    // Point to local Behat default Profile
    grunt.registerTask('behatLocal', [ 'shell:phantomJS' ]);

    // Point to local Behat Selenium on Guest Machine
    grunt.registerTask('behatvmSelenium', [ 'behat:behatvmSelenium' ]);

    // Point to local Behat Selenium on Host Machine
    grunt.registerTask('behatLocalSelenium', [ 'behat:localSelenium' ]);

    // Point to Jenkins Dev environment
    grunt.registerTask('behatJenkinsDev', [ 'behat:jenkinsDev' ]);

    // Point to Jenkins Stage environment
    grunt.registerTask('behatJenkinsStage', [ 'behat:jenkinsStage' ]);

};
