pipeline {
    agent any
    stages {
        stage('Push Script to Remote') {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'aws-deployer-ssh-key', keyFileVariable: 'SSH_KEY')]) {
                    sh 'scp -i $SSH_KEY -o StrictHostKeyChecking=no cleanup_script.sh ubuntu@172.22.1.146:/tmp/'
                    sh 'ssh -i $SSH_KEY -o StrictHostKeyChecking=no ubuntu@172.22.1.146  "bash /tmp/cleanup_script.sh"'
                }
            }
        }
    }
}