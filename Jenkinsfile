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
        stage('Maven Build') {
            steps {
                sh '/opt/apache-maven-3.9.6/bin/mvn clean deploy'
            }
        }
        stage('SonarQube Analysis') {
            environment {
                scannerHome = tool 'dops-sonar-scanner'
            }
            steps {
                withSonarQubeEnv('dops-sonarcube-server') {
                    sh "${scannerHome}/bin/sonar-scanner -X"
                }
            }
        }
    }
}