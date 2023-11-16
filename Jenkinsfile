pipeline {
    agent {
        node{
        label 'w2'
        }
    }

    stages {
        stage('Checkout') {
            steps {
                // Get some code from a GitHub repository
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Niveditha-nk/maven-project.git']]])
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
                sh "docker build -t webapp:v${BUILD_NUMBER} ."
            }
        }
        
        stage('Publish to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub_credentials', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
        	        sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
                    sh "docker tag webapp:v${BUILD_NUMBER} ${env.dockerHubUser}/webapp:v${BUILD_NUMBER}"
                    sh "docker push ${env.dockerHubUser}/webapp:v${BUILD_NUMBER}"
                }

            }
        }
    }
}
