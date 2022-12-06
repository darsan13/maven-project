pipeline {
    agent {
        label 'node2'
    }
        

    stages {
        stage('Checkout') {
            steps {
                // Get some code from a GitHub repository
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/darsan-antra/maven-project.git']]])
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
        
        stage('Publsih to Docker Hub ') {
            steps {
                sh "docker tag webapp:v${BUILD_NUMBER} saidevopsworld/webapp:v${BUILD_NUMBER}"
                sh "docker push saidevopsworld/webapp:v${BUILD_NUMBER}"
            }
        }
        
        stage('Create Container') {
            steps {
                sh "docker run --name webapp_v${BUILD_NUMBER} -p 8086:8080 -d webapp:v${BUILD_NUMBER}"
            }
        }    
    }
}



