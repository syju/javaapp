pipeline {
environment {
registry = "matt96/tomimg"
registryCredential = 'dockerhub-cred'
dockerImage = ''
}    

    agent {label 'slave01'}

    tools {
        // Note: this should match with the tool name configured in your jenkins instance (JENKINS_URL/configureTools/)
        maven "maven-4.0.0"
    }

    
    stages {
        stage("clone code") {
            steps {
                script {
                    // Let's clone the source
                    git 'https://github.com/syju/javaapp.git';
                }
            }
        }
        stage('SonarQube analysis') {
    //  def scannerHome = tool 'SonarScanner 4.0';
             steps {
                 withSonarQubeEnv('sonarqube-7.6') { 
    //           sh "${scannerHome}/bin/sonar-scanner"
                 sh "mvn sonar:sonar"

                }

            }

        }
        stage("mvn build") {
            steps {
                script {
                    // If you are using Windows then you should use "bat" step
                    // Since unit testing is out of the scope we skip them
                    sh script: 'mvn clean package'
                    archiveArtifacts artifacts: 'target/*.war', onlyIfSuccessful: true
                    sh script: 'cp /home/jenkins-slave/workspace/fita-job1/target/simple-app-3.0.0-SNAPSHOT.war /home/jenkins-slave/workspace/fita-job1'
                }
            }
        }

     

        stage("publish to nexus") {
            steps {
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
                credentialsId: 'nexus-pass', 
                groupId: 'in.javahome', 
                nexusUrl: '18.236.222.213:8081', 
                nexusVersion: 'nexus3', 
                protocol: 'http', 
                repository: 'maven-nexus-repo', 
                version: '${mavenPom.version}'

                }
                    
            }
        }    
            stage('Build image') {
                
              steps{
                script {
                    sh 'docker build -t tomv1:latest /home/jenkins-slave/workspace/fita-job1'
                    sh 'docker tag tomv1:latest 545283343502.dkr.ecr.us-west-2.amazonaws.com/stackimgs:latest' 
                }
            }
        }
        stage('Pushing image') {
               
            steps{
                script {
                sh "aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 545283343502.dkr.ecr.us-west-2.amazonaws.com"
                sh "docker push 545283343502.dkr.ecr.us-west-2.amazonaws.com/stackimgs:latest"
                }
            }
        }
        stage ("k8s-Deploy"){
            steps{
                script {
                   kubernetesDeploy(configs: "deploymentservice.yml", kubeconfigId: "k8s")
                }
            }
        }
    }    
}  
