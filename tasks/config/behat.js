module.exports = function(grunt) {
    grunt.config.merge({
        behat : {
            local : {
                src : 'tests/behat/features/***/**/*',
                options : {
                    config : './tests/behat/behat.yml',
                    maxProcesses : 5,
                    bin : './tests/behat/bin/behat',
                    junit : {
                        output_folder : 'tests/test_results/'
                    }
                }
            },
            vmSelenium : {
                src : './tests/behat/features/***/**/*',
                options : {
                    config : './tests/behat/behat.yml',
                    flags : '-p vm-selenium',
                    maxProcesses : 5,
                    bin : './tests/behat/bin/behat',
                    junit : {
                        output_folder : 'tests/test_results/'
                    }
                }
            },
            localSelenium : {
                src : './tests/behat/features/***/**/*',
                options : {
                    config : './tests/behat/behat.yml',
                    flags : '-p local-selenium',
                    maxProcesses : 5,
                    bin : './tests/behat/bin/behat',
                    junit : {
                        output_folder : 'tests/test_results/'
                    }
                }
            },
            jenkinsDev : {
                src : './tests/behat/features/***/**/*',
                options : {
                    config : './tests/behat/behat.jenkins.yml',
                    flags : '-p dev',
                    maxProcesses : 5,
                    bin : './tests/behat/bin/behat',
                    junit : {
                        output_folder : 'tests/test_results/'
                    }
                }
            },
            jenkinsStage : {
                src : './tests/behat/features/***/**/*',
                options : {
                    config : './tests/behat/behat.jenkins.yml',
                    flags : '-p stage',
                    maxProcesses : 5,
                    bin : './tests/behat/bin/behat',
                    junit : {
                        output_folder : 'tests/test_results/'
                    }
                }
            }
        }
    });

    grunt.loadNpmTasks('grunt-parallel-behat');
};
