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
          def nginxVersion = '1.19'
          def dockerRepoName = 'zooniverse/nginx'
          def dockerImageName = "${dockerRepoName}:${nginxVersion}"
          def newImage = docker.build(dockerImageName, "--build-args VERSION=${nginxVersion}")

          if (BRANCH_NAME == 'master') {
            stage('Push image to registry') {
              newImage.push()
            }
          }
        }
      }
    }
  }
}
