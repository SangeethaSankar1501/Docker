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
                    withCredentials([usernamePassword(credentialsId: 'dockercred', usernameVariable: 'docker_username', passwordVariable: 'docker_password')]) 
                    {
                        sh 'echo $docker_password | docker login -u $docker_username --password-stdin' 
                        echo 'Login Successfull'
                        sh 'docker build -t webapp .'
                        echo ' Build successfull'
                        sh "docker tag webapp $docker_username/webapp"
                        echo 'image tagged as $docker_username/webapp'
                        sh "docker push $docker_username/webapp"
                        echo ' image pushed to dockerhub'
                        sh "docker run -p 3000:8080 -d $docker_username/webapp"
                        echo ' application deployed successfully'
                    }
            }
        }
    }
}
}
