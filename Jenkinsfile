pipeline
{
    agent any
    environment {
        dockerimage = '$Docker_Username/webapp'
    }
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
        stage('docker build and push') {
            steps{
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockercred', usernameVariable: 'Docker_Username', passwordVariable: 'Docker_Password')]) 
                    {
                        sh 'echo $Docker_Password | docker login -u $Docker_Username --password-stdin' 
                        echo 'Login Successfull'
                        sh 'docker build -t webapp .'
                        echo ' Build successfull'
                        sh 'docker tag webapp $Docker_Username/webapp'
                        echo 'image tagged as $Docker_Username/webapp'
                        sh 'docker push $Docker_Username/webapp'
                        echo ' image pushed to dockerhub'
                    }
            }
        }
    }
        stage('app deploy') {
            steps {
                 sh 'docker run -p 3000:8080 -d ${dockerimage}'
                 echo ' application deployed successfully'
            }
        }
}
}
