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
                rake assets:precompile
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
                sh """
                ssh  root@34.73.178.208 mv /opt/minerva /opt/minerva-`date +%Y-%m-%d-%H-%M`
                scp -r ./ root@34.73.178.208:/opt/minerva/
                ssh  root@34.73.178.208 'cd /opt/minerva && /usr/local/bin/bundle install'
                ssh  root@34.73.178.208 systemctl restart puma
                """
            }
        }
    }
}
