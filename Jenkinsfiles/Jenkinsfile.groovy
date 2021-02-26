job('DSL-job-1') {
//    agent {
            label( 'jenkins-agent-ubuntu' )
//        }
//	options {
//        buildDiscarder(logRotator(numToKeepStr: '100', artifactNumToKeepStr: '20'))
//        timestamps()
//    }
//	docker.withServer('unix:///var/run/docker.sock') {
        stages {
            stage('Parameters'){
			options { timeout(time: 30, unit: 'MINUTES') }
                steps {
                    script {
                    properties([
                            parameters([
                                [$class: 'ChoiceParameter',
                                    choiceType: 'PT_SINGLE_SELECT',
                                    description: 'Select the Stage from the Dropdown List',
                                    filterLength: 1,
                                    filterable: false,
                                    name: 'Stage',
                                    script: [
                                        $class: 'GroovyScript',
                                        fallbackScript: [
                                            classpath: [],
                                            sandbox: false,
                                            script:
                                                "return['Could not get the stage']"
                                        ],
                                        script: [
                                            classpath: [],
                                            sandbox: false,
                                            script:
                                                "return['Build','Run','Push','Remove_Images','Remove_Containers']"
                                        ]
                                    ]
                                ],
                                [$class: 'CascadeChoiceParameter',
                                    choiceType: 'PT_SINGLE_SELECT',
                                    description: 'Select the Parameter from the Dropdown List',
                                    name: 'Docker',
                                    referencedParameters: 'Stage',
                                    script:
                                        [$class: 'GroovyScript',
                                        fallbackScript: [
                                                classpath: [],
                                                sandbox: false,
                                                script: "return['Could not get Parameter from Stage Param']"
                                                ],
                                        script: [
                                                classpath: [],
                                                sandbox: false,
                                                script: '''
                                                if (Stage.equals("Build")){
                                                    return["master", "agent-ubuntu"]
                                                }
                                                else if(Stage.equals("Run")){
                                                    return["master", "agent-ubuntu"]
                                                }
                                                else if(Stage.equals("Remove_Images")){
                                                    return["master", "agent-ubuntu"]
                                                }
												else if(Stage.equals("Remove_Containers")){
                                                    return["master", "agent-ubuntu"]
                                                }
                                                '''
                                            ]
                                    ]
                                ],
                                [$class: 'DynamicReferenceParameter',
                                    choiceType: 'ET_ORDERED_LIST',
                                    description: 'Select the  AMI based on the following infomration',
                                    name: 'Execute',
                                    referencedParameters: 'Env',
                                    script:
                                         [$class: 'GroovyScript',
                                          fallbackScript: [
                                                  classpath: [],
                                                  sandbox: false,
                                                  script: "return['Could not get Parameter from Execute Param']"
                                          ],
                                          script: [
                                                classpath: [],
                                                sandbox: false,
                                                script: '''
                                                    if (Stage.equals("Build")) && (Docker.equals("master")){
                                                    echo -e 'Building jenkins-agent-ubuntu \n\n'
													sh "bash /home/sunny/yada/images/master/bin/image-build.Unix.sh"
													return[master:image-build.Unix.sh]
												}
												else if (Stage.equals("Build")) && (Docker.equals("agent-ubuntu")){
													echo -e 'Building jenkins-agent-ubuntu \n\n'
					                                sh "bash /home/sunny/yada/images/agent-ubuntu/bin/image-build.sh"
													return[agent-ubuntu:image-build.sh]
                                                }
                                                else if (Stage.equals("Run")) && (Docker.equals("master")){
                                                    echo -e 'Run jenkins-master \n\n'
					                                sh "bash /home/sunny/yada/images/master/bin/container-run.Unix.sh"
													return[master:container-run.Unix.sh]
												}
												else if (Stage.equals("Run")) && (Docker.equals("agent-ubuntu")){
				                                    echo -e 'Run jenkins-agent-ubuntu \n\n'
					                                sh "bash /home/sunny/yada/images/agent-ubuntu/bin/container-run.sh"
													return[agent-ubuntu:container-run.sh]
                                                }
                                                else if (Stage.equals("Remove_Images")) && (Docker.equals("master")){
                                                    echo -e 'Remove jenkins-master image \n\n'
					                                sh "bash /home/sunny/yada/images/master/bin/image-remove.sh"
													return[master:image-remove.sh]
												}
												else if (Stage.equals("Remove_Images")) && (Docker.equals("agent-ubuntu")){
				                                    echo -e 'Remove jenkins-agent-ubuntu image \n\n'
					                                sh "bash /home/sunny/yada/images/agent-ubuntu/bin/image-remove.sh"
													return[agent-ubuntu:image-remove.sh]
                                                }
												else if (Stage.equals("Remove_Containers")) && (Docker.equals("master")){
                                                    echo -e 'Remove jenkins-master Container \n\n'
					                                sh "bash /home/sunny/yada/images/master/bin/container-stop.sh"
													return[master:container-stop.sh]
												}
												else if (Stage.equals("Remove_Containers")) && (Docker.equals("agent-ubuntu")){
													echo -e 'Remove jenkins-agent-ubuntu Container \n\n'
					                                sh "bash /home/sunny/yada/images/agent-ubuntu/bin/container-stop.sh"
													return[agent-ubuntu:container-stop.sh]
                                                }
                                                    '''
                                                ]
                                        ]
                                ]
                            ])
                        ])
                    }
                }
            }
        }
//     }
}