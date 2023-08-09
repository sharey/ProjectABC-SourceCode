pipeline {
    agent { label 'docker' }

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
	stage('Prune Docker System') {
	    steps {
		sh "CONT_ID=$(docker ps -q)"
		sh "docker stop $CONT_ID"
		sh 'docker system prune -f'
	    }
	}
	stage('Docker Build an Image and Tag') {
            steps {
                sh 'docker build -t edurekaprojectabc:latest .' 
                sh 'docker tag edurekaprojectabc shraddhaw/edurekaprojectabc:latest'
                //sh 'docker tag samplewebapp shraddhaw/edurekaprojectabc:${env.BUILD_NUMBER}'
                
            }
        }
        // Docker pipeline plugin is needed to use DockerHub credentials
        stage('Publish image to Docker Hub') {
            steps {
                withDockerRegistry([ credentialsId: "dockerHub", url: "" ]) {
                    sh  'docker push shraddhaw/edurekaprojectabc:latest'
                    //  sh  'docker push shraddhaw/edurekaprojectabc:${env.BUILD_NUMBER}' 
                }
            }
        }
        stage('Run Docker container on Jenkins Agent') { 
            steps {
                sh 'docker run -d -p 8003:8080 shraddhaw/edurekaprojectabc:latest'
            }
        }
    }
}
    
