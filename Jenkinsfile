pipeline {
    agent any

    tools {
     jdk 'jdk 17'
     maven 'mvn 3'
    }

    environment{
        SCANNER_HOHE= tool 'SonarQube-Scanner'
    }
    stages {
        stage('Git Checkout') {
            steps {
                 git branch: 'master', url: 'https://github.com/MadhumithaRJ/mysql-application.git'
            }
        }

        stage('Integration Test') {
            steps {
                sh "mvn clean install -DskipTests=true"
            }
        }

        stage('Maven Compile') {
            steps {
                echo "Maven Compile started..."
                sh "mvn compile"
            }
        }

        // stage('SonarQube-Analysis') {
        //     steps {
        //         script {
        //          echo "sonarqube code analysis"
        //          withSonarQubeEnv(credentialsId: 'sonar-token') {
        //              sh 'mvn sonar:sonar -Dsonar.projectKey=my-sql -Dsonar.host.url=http://18.234.254.130:9000'
        //              echo "End of sonarqube code analysis"

        //            }
        //         }
        //     }
        // }
        stage('Docker Images') {
            steps {
                script {
                 echo "Docker Image started..."
                 withDockerRegistry(credentialsId: 'docker-cred', toolName: 'docker') {
                    sh "docker build -t my-sql-app ."
                 }
                 echo "End of Docker Images"
                }
            }
        }

        stage("Tag & Push to DockerHub"){
            steps{
                script {
                    echo "Tag & Push to DockerHub Started..."
                    withDockerRegistry(credentialsId: 'docker-cred', toolName: 'docker') {
                      sh "docker tag my-sql-app $madhumithaj2000/my-sql-app:latest"
                      sh "docker push $madhumithaj2000/my-sql-app:latest "
                    }
                    echo "End of Tag & Push to DockerHub"
                }
            }
        }

        stage('Docker Image Scan') {
            steps {
                sh "trivy image my-sql-app"
            }
        }


    }
}
