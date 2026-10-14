pipeline {
  agent any
  environment {
    DB_SERVER = 'localhost'
    DB_NAME   = 'demo_cicd'
  }
  stages {
    stage('Checkout') {
      steps { checkout scm }
    }
    stage('Deploy to Dev DB') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'sql-ci-cred',
                         usernameVariable: 'DB_USER', passwordVariable: 'DB_PASS')]) {
          powershell './scripts/deploy.ps1 -Server $env:DB_SERVER -Database $env:DB_NAME -User $env:DB_USER -Password $env:DB_PASS'
        }
      }
    }
  }
}
