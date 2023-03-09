pipeline{

    agent {label 'jenkins-slave01'}

    tools {
        maven "maven 3.9.0"
    }

    stages {
        stage("clone git code"){
            steps{
                script {
                    git 'https://github.com/syju/javaapp.git'
                }
            }
        }

        stage('Sonarqube Analysis'){
            steps{
                withSonarQubeEnv('sonarqube-7.6'){
                     sh "mvn sonar:sonar"
                }
            }
        }

        stage("maven build"){
            steps{
                script {
                    sh script: 'mvn clean package'
                    archiveArtifacts artifacts: 'target/*.war', onlyIfSuccessful: true
                }
            }
        }

        stage('Publish to Nexus'){
            steps{
                script{
                    def mavenPom = readMavenPom file: 'pom.xml'
                    def nexusRepoName = mavenPom.version.endsWith("SNAPSHOT") ? "simpleapp-snapshot" : "simpleapp-release"
                    nexusArtifactUploader artifacts: [
                        [   
				 
				            artifactId: 'simple-app', 
					        classifier: '', 
					        file: 'target/simple-app-3.0.0-SNAPSHOT.war', 
					        type: 'war' 
					    ]   
				
		            ], 
		
		            credentialsId: 'nexus_pass', 
		            groupId: 'in.javahome', 
		            nexusUrl: '54.185.5.41:8081', 
		            nexusVersion: 'nexus3', 
		            protocol: 'http', 
	                repository: 'maven-nexus-repo', 
		            version: '${mavenPom.version}'

                }
            }
        }
        stage('Build image'){
            steps{
                script{
                    sh "docker build -t tomv1:latest /home/jenkins-slave/workspace/devops-night-01"
                    sh "docker tag tomv1:latest 545283343502.dkr.ecr.us-west-2.amazonaws.com/web-repository:latest"
                }
            }
        }       
        stage('Pushing image to ECR'){
            steps{
                script{
                    sh "aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 545283343502.dkr.ecr.us-west-2.amazonaws.com"
                    sh "docker push 545283343502.dkr.ecr.us-west-2.amazonaws.com/web-repository:latest"
                }
            }
        }
        stage('k8s-deployment'){
            steps{
                script{
                    kubernetesDeploy(configs: "deploymentservice.yml", kubeconfigId: "K8s")
                }
            }
        }
    }
}
