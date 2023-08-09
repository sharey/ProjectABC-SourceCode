pipeline {
    agent { label 'slave2' }

    stages {
        stage('Compile Source Code') {
            steps {
                sh 'mvn compile'             
            }
        }
        stage('Test Source Code') {
            steps {
                sh 'mvn test'             
            }
        }
        stage('Package Source Code') {
            steps {
                sh 'mvn package'             
            }
        }
    }
}
    
