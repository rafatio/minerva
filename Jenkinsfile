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
                rake assets:precompile
                rake tmp:clear
                rake log:clear
                """
            }
        }
        stage('Deploy') {
            steps {
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