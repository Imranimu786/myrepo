pipeline {
    agent any
    stages {
        stage('clean_workspace') {
            steps {
                // You can choose to clean workspace before build as follows
                cleanWs deleteDirs: true, notFailBuild: true
                checkout scm
               
            }
        }
        
        stage ('Build') {
            steps { 
                    sh 'mvn clean install -DskipTests=true '                                    
               }
         }
	    stage ('docker image build') {
		 environment
			{
				aws_access_key = credentials('aws-access-key')
				secret_key = credentials('secret-access-key')
                  }

             steps {
                     sh 'aws configure set aws_access_key_id $aws_access_key'
		     sh 'aws configure set aws_secret_access_key $secret_key'
		     sh 'aws configure set default.region us-east-1'
		     sh 'aws ecr get-login-password --region us-east-1 | sudo docker login --username AWS --password-stdin 227689816422.dkr.ecr.us-east-1.amazonaws.com'
                     sh 'sudo docker build ./ -t sample-java'
                     sh 'sudo docker tag sample-java:latest 227689816422.dkr.ecr.us-east-1.amazonaws.com/sample-java:latest'
                     sh 'sudo docker push 227689816422.dkr.ecr.us-east-1.amazonaws.com/sample-java:latest'
  		     
             }    
                    
        }
        

                   
    }
}
