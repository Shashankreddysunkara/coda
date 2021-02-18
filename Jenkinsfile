node('master') {
    docker.withServer('unix:///var/run/docker.sock') {
        stage('Git clone') {
            git 'git@github.com:Shashankreddysunkara/coda.git'
        }
        stage('Build') {
            docker
                .image('jenkins-agent-ubuntu')
                .inside('--volumes-from jenkins-master') {
                    sh "bash ./build.sh;"
                }
        }
        stage('Copy build results') {
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
        stage('UI unit tests') {
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
