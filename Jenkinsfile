def registry = 'https://solutionsarchitect.jfrog.io/'

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
        stage("Jar Publish") {
            steps {
                script {
                        echo '<--------------- Jar Publish Started --------------->'
                        def server = Artifactory.newServer url:registry+"/artifactory" ,  credentialsId:"jfrog-cred-release"
                        def properties = "buildid=${env.BUILD_ID},commitid=${GIT_COMMIT}";
                        def uploadSpec = """{
                            "files": [
                                {
                                "pattern": "jarstaging/(*)",
                                "target": "dops-libs-release-local/{1}",
                                "flat": "false",
                                "props" : "${properties}",
                                "exclusions": [ "*.sha1", "*.md5"]
                                }
                            ]
                        }"""
                        def buildInfo = server.upload(uploadSpec)
                        buildInfo.env.collect()
                        server.publishBuildInfo(buildInfo)
                        echo '<--------------- Jar Publish Ended --------------->'  
                
                }
            }   
        }   

    }
}
