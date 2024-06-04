curl -s https://deb.nodesource.com/setup_18.18.2 | sudo bash

sudo apt install nodejs -y

node -v

yarn global add @vue/cli

# pipeline script

pipeline {
    agent any

    stages {
        stage('checkout') {
            steps {
                git 'https://github.com/AchillesLe/vue-project.git'
            }
        }

        stage('clear workspace') {
            steps {
                sh 'rm -rf ${WORKSPACE}/dist'
            }
        }

        stage('build') {
            steps {
                sh 'npm install'
                sh 'npm run build'
            }
        }

        stage('upload artifact') {
            steps {
                sh 'aws s3 cp ${WORKSPACE}/dist/ s3://udemy-vue-static-hosting/ --recursive'
            }
        }
    }
}