pipeline{
    agent any
    tools {
      maven 'maven3'
    }
    environment {
      DOCKER_TAG = getVersion()
    }
    stages{
        stage('SCM'){
            steps{
                git credentialsId: 'github', 
                    url: 'https://github.com/clickoncloud-kubernets/maven-app'
            }
        }
        
        stage('Maven Build'){
            steps{
                sh "mvn clean package"
            }
        }
        
        stage('Docker Build'){
            steps{
                sh "docker build . -t clickoncloudkubernets/maven-app:${DOCKER_TAG} "
            }
        }
        
        stage('DockerHub Push'){
            steps{
                withCredentials([string(credentialsId: 'docker-hub', variable: 'dockerHubPwd')]) {
                    sh "docker login -u soumenbiswas212 -p ${dockerHubPwd}"
                }
                
                sh "docker push clickoncloudkubernets/maven-app:${DOCKER_TAG} "
            }
        }
		
        stage('Connect Kubernets'){
            steps{
                sh "cp -i kubernets/admin.conf $HOME/.kube/config"
		sh "chown jenkins:jenkins $HOME/.kube/config"
		sh "kubectl get nodes"    
            }
        }		
		
		
		
		
    }     

}

def getVersion(){
    def commitHash = sh label: '', returnStdout: true, script: 'git rev-parse --short HEAD'
    return commitHash
}
