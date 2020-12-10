#!groovy

pipeline {
  agent none

  options {
    disableConcurrentBuilds()
  }

  stages {
    stage('Build Docker image') {
      agent any
      steps {
        script {
          def nginxVersion = '1.19.0'
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
