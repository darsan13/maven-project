pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Get some code from a GitHub repository
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/DevOpsHubIN/maven-project.git']]])
            }
        }
        
        stage('Build') {
            steps {
                // Run Maven on a Unix agent.
                sh "mvn clean package"
            }
        }
        
        stage('Build Docker Image') {
            steps {
                sh "docker build -t mywebapp:v${BUILD_NUMBER} ."
                sh "docker tag mywebapp:v${BUILD_NUMBER} devopshub2020/mywebapp:v${BUILD_NUMBER}"
            }
        }
        
        stage('Publish to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub_credentials', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
        	        sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
                }
                sh "docker push avinash9604/mywebapp:v${BUILD_NUMBER}"
            }
        }
    }
}
