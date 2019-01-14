pipeline {
    agent any

    environment {
        RAILS_MASTER_KEY = credentials('rails_master_key')
        PATH = "/usr/local/bin:$PATH"
    }

    stages {
        stage('Build') {
            steps {
                sh """
                bundle install
                rake assets:precompile
                bundle install
                rails db:migrate
                rake tmp:clear
                rake log:clear
                """
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}