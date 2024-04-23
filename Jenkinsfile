pipeline {
    agent any
    tools{
        jdk 'java17'
        maven 'maven3'
    }
    environment{
       SCANNER_HOME = tool 'sonar-scanner'
    }
    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/sunil3gs98/spring-framework-petclinic-sunil'
            }
        }
        stage('Code-Compile') {
            steps {
                sh "mvn clean compile"
                
            }
        }
        stage('Test cases') {
            steps {
                sh "mvn test"
                
            }
        }
        stage('Sonarqube Analysis') {
            steps {
                withSonarQubeEnv('sonar') {
                    sh ''' $SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=spring-petclinic \
                   -Dsonar.java.binaries=. \
                   -Dsonar.projectKey=Pet '''
                }
                
                
            }
        }
        stage('Build Application') {
            steps {
                sh "mvn clean package"
            }
        }
        
        
        
       stage('OWASP Dependency Check') {
            steps {
                dependencyCheck additionalArguments: ' --scan target/ ', odcInstallation: 'owasp'
            
                    
            }
        }
        
        
        stage('Nexus') {
            steps {
                configFileProvider([configFile(fileId: '94428c70-8b67-460c-a3fb-d5408d59b984', variable: 'mavensettings')]) {
                  
                  sh "mvn -s $mavensettings clean deploy "
                  
                }
                
            }
        }
        
        stage("Docker Image Build "){
            steps{
                script{
                   withDockerRegistry(credentialsId: '6142eb30-9e73-4e3a-bb0f-fa120814eb28') {
                        
                        sh "docker build -t petclinic-sunil ."
                        sh "docker tag petclinic sunil3gs98/petclinic-sunil:latest"
                       // sh "docker push sunil3gs98/petclinic:latest"
                        
                       
                    }
                }
            }
        }
        
         stage('Trivy Scan') {
            steps {
                sh "trivy image sunil3gs98/petclinic-sunil:latest > trivy-report.txt"
                
            }
        }
        
        stage("Docker  Push"){
            steps{
                script{
                   withDockerRegistry(credentialsId: '6142eb30-9e73-4e3a-bb0f-fa120814eb28') {
                        
                        sh "docker push sunil3gs98/petclinic-sunil:latest"
                        
                       
                    }
                }
            }
        }
    }
}
