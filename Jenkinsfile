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
                    sh 'echo "Deploying..."'
                    sh 'docker build -f deploy.DockerFile -t dummy-publish .'
                }
              }
              
              stage("publish") {
                steps {
                    sh 'echo "publish..."'
                    sh 'docker build -f publish.DockerFile -t dummy-publish .'
                }
              }
            }
        }
    }
}
