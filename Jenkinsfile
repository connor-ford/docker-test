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

        stage('Test & Build') {
            agent {
                docker { image env.NODE_IMG }
            }
            steps {
                sh 'npm run test'
                sh 'npm run build'
            }
            post {
                always {
                    archiveArtifacts artifacts: 'dist/**', allowEmptyArchive: true
                }
            }
        }

        stage('Deployment Simulation') {
            steps {
                sh "mkdir -p ${env.STAGING_DIR}"
                sh "cp -r dist/* ${env.STAGING_DIR}/"
                echo "SUCCESS: Application deployed from dist/ to: ${env.STAGING_DIR}"
            }
        }
    }
}
