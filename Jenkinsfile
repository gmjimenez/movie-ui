pipeline {
  agent {
    label 'master'
  }
  tools {
    nodejs 'nodejs'
    dockerTool 'docker'
  }
  environment {
        CI = 'true'
  }
  stages {
    stage('tree') {
      steps {
        sh 'tree'
        sh 'pwd'
      }
    }
    stage('Install docker') {
      steps {
        sh 'docker --version'
      }
    }

    stage('Build') {
      steps {
        sh 'npm install'
      }
    }
    /*  stage('clean') {
      cleanWs()
    } */
    /*stage('Gen .deb') {
      steps {
        sh 'docker build -t movie-api:latest .'

      }
    } */
    stage('push artifact') {
      steps {
        sh 'chmod +x deb.sh'
        sh './deb.sh'
        dir('/var/lib/jenkins/workspace/') {
          sh 'pwd'
          // sh 'git clone git@github.com:gmjimenez/api-artifacts.git'
          sh 'ls'
        }
        dir('/var/lib/jenkins/workspace/api-artifacts') {
          sh 'mkdir movie-ui'
        }
        dir('/var/lib/jenkins/workspace/') {
          sh 'cp movie-ui.deb api-artifacts/movie-ui'
        }
        dir('/var/lib/jenkins/workspace/api-artifacts') {
          sh 'git add .'
          sh 'git commit -m "ui.deb:latest"'
          sh 'git remote add origin https://gmjimenez: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@github.com/gmjimenez/api-artifacts.git'
          sh 'git push  '
        }
      }
    }
    post {
        always {
            cleanWs()
        }
    }

    //stage('Test') {
    //steps {
    //sh 'npm test'
    //}
    //
    }
  }

