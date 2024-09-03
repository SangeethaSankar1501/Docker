pipeline
{
    agent any
    stages
    {
        stage('code checkout') {
            steps{
                echo 'code checkout complete'
            }
        }
        stage('maven build') {
            steps{
                sh 'mvn clean install'
                echo ' build complete'
            }
        }
        stage('application deploy') {
            steps{
                script {
                    withCredentials([usernamePassword(credentialsId: 'awscred', usernameVariable: 'aws_access_key_id', passwordVariable: 'aws_secret_key_id')]) 
                    {
                        sh 'aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 590183905103.dkr.ecr.us-east-2.amazonaws.com' 
                        echo 'Login Successfull'
                        sh 'docker build -t testrepo .'
                        echo ' Build successfull'
                        sh "docker tag testrepo:latest 590183905103.dkr.ecr.us-east-2.amazonaws.com/testrepo:latest"
                        echo 'image tagged as 590183905103.dkr.ecr.us-east-2.amazonaws.com/testrepo:latest'
                        sh "docker push 590183905103.dkr.ecr.us-east-2.amazonaws.com/testrepo:latest"
                        echo ' image pushed to dockerhub'
                        sh "docker run -p 3000:8080 -d 590183905103.dkr.ecr.us-east-2.amazonaws.com/testrepo:latest"
                        echo ' application deployed successfully'
                    }
            }
        }
    }
}
}
