#1: setup docker on VPS

#2 add jenkins pipeline script on vps


pipeline {
    agent any
    stages {
        stage('checkout') {
            steps {
                git 'https://github.com/AchillesLe/loadbalance-nginx-docker.git'
            }
        }

        stage ('build image') {
            steps {
                sh 'docker build -t nodejs-random-color .'
            }
        }

        # stage ('update image') {
        #     steps {
        #         # sh 'docker build -t nodejs-random-color .'
        #     }
        # }
    }
}