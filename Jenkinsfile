pipeline{
    agent{
        node{
            label "Slave-1"
            customWorkspace "/home/jenkins/mydemo"
        }
    }
    environment{
        JAVA_HOME="/usr/lib/jvm/java-17-amazon-corretto.x86_64"
        PATH="$PATH:/opt/sonar-scanner/bin:/opt/dependency-check/bin:/opt/node-v16.0.0-linux-x64/bin:/usr/local/bin"
    }
    parameters {
        string(name: 'COMMIT_ID', defaultValue: '', description: 'Provide the Commit ID')
        string(name: 'REPO_NAME', defaultValue: '', description: 'Provide ECR Repository URI')
        string(name: 'TAG_NAME', defaultValue: '', description: 'Provide a tag name for Docker Image')
        string(name: 'REPLICA_COUNT', defaultValue: '', description: 'Provide the number of Pods to be created')
    }
    stages{
        stage("clone-code"){
            steps{
                cleanWs()
                checkout scmGit(branches: [[name: '${COMMIT_ID}']], extensions: [], userRemoteConfigs: [[credentialsId: 'github-cred', url: 'https://github.com/singhritesh85/Swiggy-Clone-App.git']])
            }
        }
        stage("SonarAnalysis"){
            steps {
                withSonarQubeEnv('SonarQube-Server') {
                    sh 'sonar-scanner -Dsonar.projectKey=swiggy-clone -Dsonar.projectName=swiggy-clone'
                }
            }
        }
        stage("Quality Gate") {
            steps {
              timeout(time: 1, unit: 'HOURS') {
                waitForQualityGate abortPipeline: true
              }
            }
        }
        stage("Install Dependencies"){
            steps {
                sh 'npm install'
            }
        }
        stage("OWASP Dependency Check"){
            steps{
                sh 'dependency-check.sh --disableYarnAudit --disableNodeAudit --scan . --out .'
            }
        }
        stage("Trivy Scan files"){
            steps{
                sh 'trivy fs . > /home/jenkins/trivy-filescan.txt'
            }
        }
        stage("Docker-Image"){
            steps{
                sh 'docker build --no-cache -t myimage:1.06 .'
                sh 'docker tag myimage:1.06 ${REPO_NAME}:${TAG_NAME}'
                sh 'trivy image --exit-code 0 --severity MEDIUM,HIGH ${REPO_NAME}:${TAG_NAME}'
                sh 'aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 027330342406.dkr.ecr.us-east-2.amazonaws.com'
                sh 'docker push ${REPO_NAME}:${TAG_NAME}'
            }
        }
        stage("Deployment"){
            steps{
                //sh 'yes|argocd login argocd.singhritesh85.com --username admin --password Admin@123'
                sh 'argocd login argocd.singhritesh85.com --username admin --password Admin@123 --skip-test-tls  --grpc-web'
                sh 'argocd app create swiggy-clone --project default --repo https://github.com/singhritesh85/helm-repo-for-swiggy-clone.git --path ./folo --dest-namespace swiggy --dest-server https://kubernetes.default.svc --helm-set service.port=80 --helm-set image.repository=${REPO_NAME} --helm-set image.tag=${TAG_NAME} --helm-set replicaCount=${REPLICA_COUNT} --upsert'
                sh 'argocd app sync swiggy-clone'
            }
        }
    }
}
