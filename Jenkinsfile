pipeline {

    agent any

    stages {

        stage('Git Checkout'){

            steps{

                git branch: 'main', credentialsId: 'github-credential', url: 'https://github.com/Mohamed-Tharwat-El-Sayed/devops-project-java-app.git'
            }
        }

    }
}

