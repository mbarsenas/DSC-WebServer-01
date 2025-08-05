pipeline {
    agent any

    environment {
        WIN_SERVER = '18.216.227.250'
        WIN_USER = 'Administrator'
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
                    script {
                        writeFile file: 'deploy.ps1', text: """
\$securePass = ConvertTo-SecureString '\$env:PASS' -AsPlainText -Force
\$cred = New-Object System.Management.Automation.PSCredential('\$env:USER', \$securePass)
New-PSDrive -Name Z -PSProvider FileSystem -Root "\\\\${env.WIN_SERVER}\\c\$" -Credential \$cred -Persist
Copy-Item -Path ${env.LOCAL_FILE} -Destination "Z:\\inetpub\\wwwroot\\" -Force
Remove-PSDrive -Name Z
"""
                        powershell 'powershell.exe -ExecutionPolicy Bypass -File deploy.ps1'
                    }
                }
            }
        }
    }
}
