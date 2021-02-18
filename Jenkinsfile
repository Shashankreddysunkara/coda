pipeline {
    agent any
    docker.withServer('unix:///var/run/docker.sock') {
    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                docker
                .image('jenkins-agent-ubuntu')
                .inside('--volumes-from jenkins-master') {
                    sh "bash ./build.sh;"
                }
            }
        }
        stage('Copy build results') {
            steps {
                echo 'Testing..'
               docker
               .image('jenkins-agent-ubuntu')
               .inside('--volumes-from jenkins-master') {
                   sh """
                       sshpass -plol scp \
                           "${WORKSPACE}/build/*.tar.gz" \
                           "backup@1.1.1.1:/builds";
                   """
               }
            }
        }
        stage('UI unit tests') {
            steps {
                echo 'Deploying....'
                docker
                    .image('jenkins-agent-ubuntu')
                    .inside('--volumes-from jenkins-master') {
                        sh """
                            cd ./tests;
                            bash ./run.sh;
                        """
                    }
            }
        }
    }
  }
}
