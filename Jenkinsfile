//def dockerImage
//jenkins needs entrypoint of the image to be empty
//def runArgs = '--entrypoint \'\''
pipeline {
    agent {
        label 'jenkins-agent-ubuntu'
    }
    options {
        buildDiscarder(logRotator(numToKeepStr: '100', artifactNumToKeepStr: '20'))
        timestamps()
    }
//	docker.withServer('unix:///var/run/docker.sock') {
    stages {
        stage('Build') {
            options { timeout(time: 30, unit: 'MINUTES') }
            steps {
                script {
//                    def commit = checkout scm
                    // we set BRANCH_NAME to make when { branch } syntax work without multibranch job
//                    env.BRANCH_NAME = commit.GIT_BRANCH.replace('origin/', '')
                    echo 'Building jenkins-master'
					sh "bash /home/sunny/yada/images/master/bin/image-build.Unix.sh"
//                    dockerImage = docker.build("jenkins-master:${env.BUILD_ID}",
//                        "--label \"GIT_COMMIT=${env.GIT_COMMIT}\""
//                        + " --build-arg MY_ARG=myArg"
//   					  + "-f /home/sunny/yada/images/master/Dockerfile"
//                        + " ~/yada/."
//                    )
                }
				script {
				echo 'Building jenkins-agent-ubuntu'
					sh "bash /home/sunny/yada/images/agent-ubuntu/bin/image-build.sh"
//                    dockerImage = docker.build("jenkins-agent-ubuntu:${env.BUILD_ID}",
//                        "--label \"GIT_COMMIT=${env.GIT_COMMIT}\""
//                        + " --build-arg MY_ARG=myArg"
//   					  + "-f /home/sunny/yada/images/agent-ubuntu/Dockerfile"
//                        + " ~/yada/."
//                    )
                }
            }
        }
		stage('Run Containers') {
            options { timeout(time: 30, unit: 'MINUTES') }
            steps {
                script {
                    echo 'Run jenkins-master'
					sh "bash /home/sunny/yada/images/master/bin/container-run.Unix.sh"
                }
				script {
				echo 'Run jenkins-agent-ubuntu'
					sh "bash /home/sunny/yada/images/agent-ubuntu/bin/container-run.sh"
                }
            }
        }
//        stage('Push to docker repository') {
//            when { branch 'master' }
//           options { timeout(time: 5, unit: 'MINUTES') }
//            steps {
//                lock("${JOB_NAME}-Push") {
//                    script {
//                        docker.withRegistry('https://myrepo:5000', 'docker_registry') {
//                            dockerImage.push('latest')
//                        }
//                    }
//                    milestone 30
//               }
//           }
//        }
    }
//  }
}