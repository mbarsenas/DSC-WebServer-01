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
                powershell """
                    \$secpasswd = ConvertTo-SecureString "$env:PASS" -AsPlainText -Force
                    \$cred = New-Object System.Management.Automation.PSCredential ("$env:USER", \$secpasswd)
                    Copy-Item -Path index.html -Destination \\\\${env:WIN_SERVER}\\c$\\inetpub\\wwwroot\\ -Credential \$cred -Force
                """


                }
            }
        }
    }
}
