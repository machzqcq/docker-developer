#docker build -t "mytlsjenkins" --build-arg dockerhost=$(docker-machine ls --filter name=$(cat ../DOCKER_MACHINE_NAME) --format "{{.URL}}") -f jenkins_tls.dockerfile .

# copy the certs created by docker-machine to root of this folder
# bin/bash copy_certs.sh

# Run as below
# docker run -d -p 8080:8080 -p 50000:50000 -v /home/docker:/var/jenkins_home mytlsjenkins
# After this the client certs should be scp as below
#docker-machine scp ~/.docker/machine/machines/default/ca.pem default:/home/docker/.docker/
#docker-machine scp ~/.docker/machine/machines/default/cert.pem default:/home/docker/.docker/
#docker-machine scp ~/.docker/machine/machines/default/key.pem default:/home/docker/.docker/

FROM jenkins:2.0

# export DOCKER_HOST environment variable
ARG dockerhost
ENV DOCKER_HOST=$dockerhost
COPY ca.pem /home/docker/.docker/ca.pem
COPY cert.pem /home/docker/.docker/cert.pem
COPY key.pem /home/docker/.docker/key.pem

ENV DOCKER_TLS_VERIFY="1"
ENV DOCKER_CERT_PATH=/home/docker/.docker
 
