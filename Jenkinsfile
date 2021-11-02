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

    stage('push artifact') {
      steps {
        sh 'chmod +x deb.sh'
        sh './deb.sh'
        dir('/var/lib/jenkins/workspace/') {
          sh 'pwd'
          sh 'git clone https://github.com/gmjimenez/api-artifacts.git'
          sh 'ls'
        }
        /* dir('/var/lib/jenkins/workspace/api-artifacts') {
          sh 'mkdir movie-ui'
        } */
        dir('/var/lib/jenkins/workspace/') {
          sh 'cp movie-ui.deb api-artifacts/movie-ui'
        }
        dir('/var/lib/jenkins/workspace/api-artifacts') {
          withCredentials([[$class : 'UsernamePasswordMultiBinding',
        credentialsId : '3b848e51-b081-417e-b53e-ee16ff82ca6e',
        usernameVariable: 'GIT_USER',
        passwordVariable: 'GIT_PASSWORD']]) {
            sh 'git add .'
            sh 'git commit -m "ui.deb:latest"'
            sh"git push https://${GIT_USER}:${GIT_PASSWORD}@github.com/${GIT_USER}/api-artifacts.git"
        }
        }
      }
    }
/*     stage('Build image') {
      steps {
        sh 'docker build -t movie-ui:latest .'
      }
}
    stage('run image') {
      steps {
        sh 'docker run -d -p 3030:3030 --name movie-ui:latest'
      //sh 'docker compose up -v'
      }
    } */
    stage('SSH Artifact') {
      steps {
        dir('/var/lib/jenkins/workspace/api-artifacts/movie-ui/') {
          sh 'ls'
          sshagent(credentials : ['rampup-devops']) {
            sh '''
            ssh -o StrictHostKeyChecking=no ubuntu@ec2-52-53-216-130.us-west-1.compute.amazonaws.com ls /tmp/
            ssh ubuntu@ec2-52-53-216-130.us-west-1.compute.amazonaws.com mkdir -p /tmp/deploy/
            scp -r movie-ui.deb ubuntu@ec2-52-53-216-130.us-west-1.compute.amazonaws.com:/tmp/deploy/
            ssh ubuntu@ec2-52-53-216-130.us-west-1.compute.amazonaws.com cd /tmp/deploy/
            ssh ubuntu@ec2-52-53-216-130.us-west-1.compute.amazonaws.com ls /tmp/deploy/
            ssh ubuntu@ec2-52-53-216-130.us-west-1.compute.amazonaws.com pwd
            ssh ubuntu@ec2-52-53-216-130.us-west-1.compute.amazonaws.com dpkg-deb -xv /tmp/deploy/movie-ui.deb /tmp/deploy/
            ssh ubuntu@ec2-52-53-216-130.us-west-1.compute.amazonaws.com ls /tmp/deploy/
            ssh ubuntu@ec2-52-53-216-130.us-west-1.compute.amazonaws.com systemctl list-units
            ssh ubuntu@ec2-52-53-216-130.us-west-1.compute.amazonaws.com forever list  
            '''
          }
        }
      }
    }
  }

    //stage('Test') {
    //steps {
    //sh 'npm test'
    //}
    //

  post {
        always {
          cleanWs()
      dir('/var/lib/jenkins/workspace/api-artifacts') {
        deleteDir()
      }
        }
  }
    }

