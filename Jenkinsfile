pipeline {
    agent any

    environment {
        WIN_SERVER = '18.216.227.250'
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
                bat('''
                    powershell -Command "Copy-Item -Path index.html -Destination \\\\%WIN_SERVER%\\c$\\inetpub\\wwwroot\\ -Credential (New-Object System.Management.Automation.PSCredential('%USER%', (ConvertTo-SecureString '%PASS%' -AsPlainText -Force)))"
                ''')

                }
            }
        }
    }
}
