pipeline {
    agent any

    environment {
        RAILS_MASTER_KEY = credentials('rails_master_key')
        DOCKER_PASS = credentials('docker_pass')
        PATH = "/usr/local/bin:$PATH"
    }

    stages {
        stage('Build') {
            steps {
                sh """
                touch ${BUILD_NUMBER}
                docker build -t guilhermeoki/minerva:${BUILD_NUMBER} . -f Dockerfile.build
                docker login --username=guilhermeoki --password=$DOCKER_PASS
                docker push guilhermeoki/minerva:${BUILD_NUMBER}
                """
            }
        }
        stage('Deploy') {
            steps {
                sh """
                ssh  root@34.73.178.208 'docker rm -f minerva || true'
                ssh  root@34.73.178.208 docker pull guilhermeoki/minerva:${BUILD_NUMBER}
                ssh  root@34.73.178.208 docker run -d -e RAILS_MASTER_KEY=${RAILS_MASTER_KEY} --name minerva guilhermeoki/minerva:${BUILD_NUMBER}
                """
            }
        }
    }
}