#FROM jenkins:2.60.3
FROM jenkins/jenkins:latest
LABEL maintainer=inusasunny@gmail.com

# root user for Jenkins
USER root

RUN mkdir /var/log/jenkins
RUN mkdir /var/cache/jenkins
RUN chown -R jenkins:jenkins /var/log/jenkins
RUN chown -R jenkins:jenkins /var/cache/jenkins

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends mercurial apt-utils systemd

USER jenkins

RUN jenkins-plugin-cli --plugins mercurial:2.12


ENV JAVA_OPTS="-Xmx8192m"
ENV JENKINS_OPTS="--handlerCountMax=300 --logfile=/var/log/jenkins/jenkins.log --webroot=/var/cache/jenkins/war"

USER root

# Environment
ENV HOME /home/ubuntu/
ENV JENKINS_HOME /home/ubuntu/sunny/jenkins
ENV JENKINS_VERSION 2.280

# GitHub repository to store _Jenkins_ configuration
ENV GITHUB_USERNAME Shashankreddysunkara
ENV GITHUB_CONFIG_REPOSITORY coda

# Make _Jenkins_ home directory
RUN mkdir -p $JENKINS_HOME

# Install _Jenkins_ plugins
RUN /usr/local/bin/install-plugins.sh \
    scm-sync-configuration:0.0.10 \
    workflow-aggregator:2.4 \
    docker-workflow:1.8

# Set timezone
RUN echo "Asia/Kolkata" > /etc/timezone &&\
    dpkg-reconfigure --frontend noninteractive tzdata &&\
    date

# Copy RSA keys for _Jenkins_ config repository (default keys).
# This public key should be added to:
# https://github.com/%YOUR_JENKINS_CONFIG_REPOSITORY%/settings/keys
COPY ./keys/jenkins.config.id_rsa     $HOME/.ssh/id_rsa
COPY ./keys/jenkins.config.id_rsa.pub $HOME/.ssh/id_rsa.pub
RUN chmod 600 $HOME/.ssh/id_rsa &&\
    chmod 600 $HOME/.ssh/id_rsa.pub
RUN echo "    IdentityFile $HOME/.ssh/id_rsa" >> /etc/ssh/ssh_config &&\
    echo "    StrictHostKeyChecking no      " >> /etc/ssh/ssh_config
RUN /bin/bash -c "eval '$(ssh-agent -s)'; echo -e " \n" | ssh-add $HOME/.ssh/id_rsa;"

# Copy RSA keys for your application repository and add
# host 'github.com-application-jenkins' for application code pulls.
# This public key should be added to
# https://github.com/%YOUR_APPLICATION_REPOSITORY%/settings/keys
COPY ./keys/jenkins.application.id_rsa     $HOME/.ssh/jenkins.application.id_rsa
COPY ./keys/jenkins.application.id_rsa.pub $HOME/.ssh/jenkins.application.id_rsa.pub
RUN chmod 600 $HOME/.ssh/jenkins.application.id_rsa &&\
    chmod 600 $HOME/.ssh/jenkins.application.id_rsa.pub
RUN touch $HOME/.ssh/config &&\
    echo "Host github.com-application-jenkins                     " >> $HOME/.ssh/config &&\
    echo "    HostName       github.com                           " >> $HOME/.ssh/config &&\
    echo "    User           git                                  " >> $HOME/.ssh/config &&\
    echo "    IdentityFile   $HOME/.ssh/jenkins.application.id_rsa" >> $HOME/.ssh/config &&\
    echo "    IdentitiesOnly yes                                  " >> $HOME/.ssh/config

# Configure git
RUN git config --global user.email "inusasunny@gmail.com" &&\
    git config --global user.name  "Shashankreddysunkara"

# Clone _Jenkins_ config
RUN cd /tmp &&\
    git clone git@github.com:$GITHUB_USERNAME/$GITHUB_CONFIG_REPOSITORY.git &&\
    mkdir -p /home/ubuntu/sunny/workspace/$GITHUB_CONFIG_REPOSITORY
    cp -r $GITHUB_CONFIG_REPOSITORY/. /home/ubuntu/sunny/workspace/$GITHUB_CONFIG_REPOSITORY &&\
    rm -r /tmp/$GITHUB_CONFIG_REPOSITORY

# _Jenkins_ workspace for sharing between containers
VOLUME /home/ubuntu/sunny/sunny_jenkins_container_volume:$JENKINS_HOME

# Run init.sh script after container start

COPY /sample/init.sh /usr/local/bin/init.sh

ENTRYPOINT ["tini", "--", "/usr/local/bin/init.sh"]