pipeline {
    agent any

    environment {
        WIN_SERVER = '172.31.47.164'
        WIN_USER = 'Administrator' // Or another user
        REMOTE_DIR = ':/c/inetpub/wwwroot/'

        LOCAL_FILE = 'index.html'
    }

    stages {
        stage('Clone Repo') {
            steps {
                git 'https://github.com/mbarsenas/DSC-WebServer-01.git'
            }
        }

        stage('Deploy to Windows Server') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'win-server-creds', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    bat """
                        pscp -pw "%PASS%" -batch index.html %USER%@%WIN_SERVER%:/c/inetpub/wwwroot/
                    """

                }
            }
        }
    }
}
