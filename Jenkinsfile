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
                post{
                    always {
                        echo 'Slack Notifications'
                        slackSend channel: '#jenkins-cicd-tabnob',
                        color: COLOR_MAP[currentBuild.currentResult],
                        message: "*${currentBuild.currentResult}:* Job ${env.JOB_NAME} build ${env.BUILD_NUMBER} \n More info at: ${env.BUILD_URL}"
                        }
                    }
                }
            }
        stage('Upload war files to Nexus'){

            steps {

                script {
                    def readFile =  readMavenPom file: 'pom.xml'

                    def nexusRepo = readFile.version.endsWith('SNAPSHOT') ? "java-app-snapshot" : "java-app-release"

                    nexusArtifactUploader artifacts: 
                    [
                        [
                            artifactId: "${readFile.artifactId}", 
                            classifier: '', 
                            file: 'target/Uber.jar', 
                            type: 'jar'
                        ]
                    ], 
                    credentialsId: 'nexus-credential', 
                    groupId: "${readFile.groupId}", 
                    nexusUrl: '192.168.0.106:8081', 
                    nexusVersion: 'nexus3', 
                    protocol: 'http', 
                    repository: nexusRepo, 
                    version: "${readFile.version}"
                }
            }
        }
        stage('Docker Image Build'){

            steps {

                script {

                    sh 'docker image build -t $JOB_NAME:v1.$BUILD_NUMBER .'
                    sh 'docker image tag $JOB_NAME:v1.$BUILD_NUMBER tharwat3551/$JOB_NAME:v1.$BUILD_NUMBER'
                    sh 'docker image tag $JOB_NAME:v1.$BUILD_NUMBER tharwat3551/$JOB_NAME:Latest'

                }
            }
        }
        stage('Push Image to The Dockerhub'){

            steps {

                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', passwordVariable: 'dockerhub_pass', usernameVariable: 'dockerhub_user')]) {
                        sh 'docker login -u ${dockerhub_user} -p ${dockerhub_pass}'
                        sh 'docker image push ${dockerhub_user}/$JOB_NAME:v1.$BUILD_NUMBER'
                        sh 'docker image push ${dockerhub_user}/$JOB_NAME:Latest'
                    }
                    
                }
            }
        }

    }
}

