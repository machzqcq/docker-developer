#docker build -t "mytlsjenkins" --build-arg DOCKERHOST=$(docker-machine ls --filter name=$(cat ../../DOCKER_MACHINE_NAME) --format "{{.URL}}") -f jenkins_tls.dockerfile .

# First copy the certs created by docker-machine to root of this folder
# bin/bash copy_certs.sh

# Run as below
# docker run -d -p 8080:8080 -p 50000:50000 -v /home/docker:/var/jenkins_home mytlsjenkins
# After this the client certs should be scp as below
#docker-machine scp ~/.docker/machine/machines/default/ca.pem default:/home/docker/.docker/
#docker-machine scp ~/.docker/machine/machines/default/cert.pem default:/home/docker/.docker/
#docker-machine scp ~/.docker/machine/machines/default/key.pem default:/home/docker/.docker/

FROM jenkins:2.0
# Add jenkins user to root group
#RUN usermod -G root jenkins
#RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers
#USER jenkins

# Add some plugins
COPY plugins.txt /var/jenkins_home/plugins.txt
RUN /usr/local/bin/plugins.sh /var/jenkins_home/plugins.txt


#USER root
# export DOCKER_HOST environment variable
ARG DOCKER_HOST
ENV DOCKER_HOST=$DOCKER_HOST
# so that jenkins can access docker daemon on docker-machine
# docker reads client certs from this location
COPY ca.pem cert.pem key.pem /home/docker/.docker/
#RUN chown -R jenkins:jenkins /home/docker/.docker/

ENV DOCKER_TLS_VERIFY="1"
ENV DOCKER_CERT_PATH=/var/jenkins_home/.docker
USER root
# Get docker client
RUN wget https://get.docker.com/builds/Linux/x86_64/docker-latest.tgz 
RUN tar xvzf docker-latest.tgz && mv ./docker/* /usr/bin/

COPY jobs/1-echo-docker-host.xml /usr/share/jenkins/ref/jobs/1-echo-docker-host/config.xml
COPY jobs/2-hello-world.xml /usr/share/jenkins/ref/jobs/2-hello-world/config.xml
COPY jobs/3-page-object.xml /usr/share/jenkins/ref/jobs/3-page-object/config.xml
COPY jobs/4-app-build-publish.xml /usr/share/jenkins/ref/jobs/4-app-build-publish/config.xml
COPY jobs/5-sample-container-exec.xml /usr/share/jenkins/ref/jobs/5-sample-container-exec/config.xml

# Config config
COPY config/config.xml /usr/share/jenkins/ref/config.xml
COPY config/hudson.plugins.sonar.SonarGlobalConfiguration.xml /usr/share/jenkins/ref/hudson.plugins.sonar.SonarGlobalConfiguration.xml
# SSH keys and creds
COPY config/credentials.xml /usr/share/jenkins/ref/credentials.xml
COPY users/admin/config.xml /var/jenkins_home/users/admin/config.xml

