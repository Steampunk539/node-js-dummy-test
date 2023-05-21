pipeline {
    agent any
    parameters {
        string(name: "ENVIRONMENT", defaultValue: "RELEASE")
        string(name: "VERSION", defaultValue: "1.0.0")
    }

    stages {
      
        stage("build") {
            steps {
                sh 'echo "Building..."'
                sh 'docker build -f build.DockerFile -t dummy-build .'
            }
        }
        
        stage("misc") {
          
            parallel {
                
              stage("test") {
                steps {
                    sh 'echo "Testing..."'
                    sh 'docker build -f test.DockerFile -t dummy-test .'
                }
              }
              
              stage("deploy") {
                steps {
                    script {
                        try {
                            timeout(time: 10, unit: 'SECONDS') {
                                sh 'echo "Deploying..."'
                                sh 'docker build -f deploy.DockerFile -t dummy-deploy .'
                            }
                        } catch (Exception e) {
                            echo e.toString()
                            if (e.toString() == "org.jenkinsci.plugins.workflow.steps.FlowInterruptedException") {
                                echo 'Success!'
                            } else {
                                throw new Exception(e.toString())
                            }
                        }
                    }
                }
              }
              
              stage("publish") {
                steps {
                  dir ('./artifact') {
                      sh 'echo "Publishing..."'
                      sh 'docker run -v $PWD:/vol-publish dummy-build:latest bash -c \"npm pack /node-js-dummy-test --pack-destination=/vol-publish/\" '
                      archiveArtifacts artifacts: '*.tgz'
                  }
                }
              }
            }
        }
    }
}
