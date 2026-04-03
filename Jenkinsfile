pipeline {
    agent any

    environment {
        STAGING_DIR = 'mock_staging'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install & Test') {
            agent {
                docker { image 'node:20-alpine' }
            }
            steps {
                sh 'npm ci'
                sh 'npm run test'
            }
        }

        stage('Build') {
            agent {
                docker { image 'node:20-alpine' }
            }
            steps {
                sh 'npm run build'
                stash name: 'build-artifacts', includes: 'dist/**'
            }
        }

        stage('Deployment Simulation') {
            steps {
                unstash 'build-artifacts'

                sh "mkdir -p ${env.STAGING_DIR}"
                sh "cp -r dist/* ${env.STAGING_DIR}/"
                echo "SUCCESS: Application deployed to: ${env.STAGING_DIR}"
            }
            post {
                always {
                    archiveArtifacts artifacts: 'dist/**', allowEmptyArchive: true
                }
            }
        }
    }
}
