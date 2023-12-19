pipeline {

    agent any

    tools {

        maven "maven 3.9.6" 
    }

    stages {

        stage('Git Checkout'){

            steps {

                git branch: 'main', credentialsId: 'github-credential', url: 'https://github.com/Mohamed-Tharwat-El-Sayed/devops-project-java-app.git'
            }
        }

        stage('Build Artifact'){

            steps {

                sh "mvn clean -DskipTest=true"
                archive 'target/*.jar'
            }
        }

        stage('Unit testing'){

            steps {
                
                sh "mvn test"
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
            }
            }
        }

        stage('Integeration Testing'){

            steps {

                sh "mvn verify -DskipUnitTests"
            }
        }

        stage('Maven Build'){

            steps {
                
                sh "mvn clean install"
            }
        }

        stage('SonarQube Analysis'){

            steps {
                withSonarQubeEnv('sonarqube') {
                sh 'mvn clean package sonar:sonar'
            }
            }
        }

        stage('Quality Gate Condition'){

            steps {
                waitForQualityGate abortPipeline: true
            }
        }

    }
}

