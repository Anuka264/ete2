pipeline {
    agent any
    
    stages {
        stage('Push Script to Remote') {
            steps {
                sshagent(['aws-deployer-ssh-key']) {
                    sh 'scp -o StrictHostKeyChecking=no cleanup_script.sh ubuntu@192.168.1.100:/tmp/'
                    sh "ssh -o StrictHostKeyChecking=no ubuntu@192.168.1.100 'bash /tmp/cleanup_script.sh'"
                }
            }
        }
    }
}