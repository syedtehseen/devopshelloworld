pipeline {
    agent {
        node {
            label 'maven'
        }
    }

    stages {

        stage('Clone Repo') {
            steps {
                git branch: 'main', url: 'https://github.com/syedtehseen/devopshelloworld.git'
            }
        }
        // environment {
        //     PATH = /opt/apache-maven-3.9.6/bin/:$PATH
        // }        
        stage('Maven Build') {
            steps {
                echo '------------------ Maven build started ----------------'
                sh '/opt/apache-maven-3.9.6/bin/mvn clean deploy -Dmaven.test.skip=true'
                echo '------------------ Maven build completed ----------------'
            }
        }
        stage('Unit Test') {
            steps {
                echo '------------------ Unit Test started ----------------'
                sh '/opt/apache-maven-3.9.6/bin/mvn surefire-report:report'
                echo '------------------ Unit Test Completed ----------------'
            }
        }

        stage('SonarQube Analysis') {
            environment {
                scannerHome = tool 'dops-sonar-scanner'
            }
            steps {
                withSonarQubeEnv('dops-sonarcube-server') {
                    sh "${scannerHome}/bin/sonar-scanner"
                }
            }
        }
    }
}
