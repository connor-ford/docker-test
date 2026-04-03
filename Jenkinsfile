pipeline {
    agent any

    environment {
        STAGING_DIR = './mock_staging'
        NODE_IMG = 'node:20-alpine'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install Dependencies') {
            agent {
                docker { image env.NODE_IMG }
            }
            steps {
                sh 'npm ci'
            }
        }

        stage('Build & Test') {
            agent {
                docker { image env.NODE_IMG }
            }
            steps {
                sh 'npm test'
                sh 'npm run build'
            }
            post {
                always {
                    archiveArtifacts artifacts: 'build/**', allowEmptyArchive: true
                }
            }
        }

        stage('Deployment Simulation') {
            steps {
                sh "mkdir -p ${env.STAGING_DIR}"
                sh "cp -r build/* ${env.STAGING_DIR}/"
                echo "SUCCESS: Application deployed to simulated staging folder: ${env.STAGING_DIR}"
            }
        }
    }
}
