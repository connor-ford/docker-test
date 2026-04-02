pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build and Test') {
            agent {
                docker {
                    image 'maven:3.9.9-eclipse-temurin-17'
                    args '-u root:root'
                }
            }
            steps {
                sh 'mvn clean test'
            }
            post {
                always {
                    archiveArtifacts artifacts: 'target/*.jar', allowEmptyArchive: true
                }
            }
        }
    }
}
