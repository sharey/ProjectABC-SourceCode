pipeline {
    agent none
    //agent { label 'docker' }

    stages {
        stage('Compile Source Code') {
            agent { label 'slave' }
	    steps {
                sh 'mvn compile'             
            }
        }
        stage('Test Source Code') {
	    agent { label 'slave' }
            steps {
                sh 'mvn test'             
            }
        }
        stage('Package Source Code') {
	    agent { label 'docker' }
            steps {
                sh 'mvn package'             
            }
        }
	stage('Prune Docker System') {
	    agent { label 'docker' }
	    steps {
		sh 'docker stop $(docker ps -q)'
		sh 'docker system prune -f'
	    }
	}
	stage('Docker Build an Image and Tag') {
	    agent { label 'docker' }
            steps {
                sh 'docker build -t edurekaprojectabc:latest .' 
                sh 'docker tag edurekaprojectabc shraddhaw/edurekaprojectabc:latest'
                //sh 'docker tag samplewebapp shraddhaw/edurekaprojectabc:${env.BUILD_NUMBER}'
                
            }
        }
        // Docker pipeline plugin is needed to use DockerHub credentials
        stage('Publish image to Docker Hub') {
	    agent { label 'docker' }
            steps {
                withDockerRegistry([ credentialsId: "dockerHub", url: "" ]) {
                    sh  'docker push shraddhaw/edurekaprojectabc:latest'
                    //  sh  'docker push shraddhaw/edurekaprojectabc:${env.BUILD_NUMBER}' 
                }
            }
        }
        stage('Run Docker container on Jenkins Agent') { 
	    agent { label 'docker' }
            steps {
                sh 'docker run -d -p 8003:8080 shraddhaw/edurekaprojectabc:latest'
            }
        }
    }
}
    
