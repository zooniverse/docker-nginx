#!groovy

pipeline {
  agent none

  options {
    disableConcurrentBuilds()
  }

  triggers { cron('@weekly') }

  stages {
    stage('Build Docker image') {
      agent any
      steps {
        script {
          def nginxVersion = '1.20'
          def dockerImageName = "zooniverse/nginx:${nginxVersion}"
          def newImage = docker.build(dockerImageName, "--build-arg VERSION=${nginxVersion} .")
          newImage.push()

          if (BRANCH_NAME == 'master') {
            stage('Push image to registry') {
              newImage.push('latest')
            }
          }
        }
      }
    }
  }
}
