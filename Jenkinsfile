pipeline {
    agent any
    stages {
        stage('Push Script to Remote') {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'aws-deployer-ssh-key', keyFileVariable: 'SSH_KEY')]) {
                    sh "scp -i $SSH_KEY -o StrictHostKeyChecking=no cleanup_script.sh ubuntu@192.168.1.100:/tmp/"
                    sh "ssh -i $SSH_KEY -o StrictHostKeyChecking=no ubuntu@192.168.1.100 'bash /tmp/cleanup_script.sh'"
                }
            }
        }
    }
}