# docker build -t "myjenkins" --build-arg dockerhost=$(docker-machine ls --filter name=$(cat docker_machine) --format "{{.URL}}") -f jenkins.dockerfile .

# Run as below
# docker run -d -p 8080:8080 -p 50000:50000 -v /home/docker:/var/jenkins_home myjenkins


FROM jenkins:2.0

# export DOCKER_HOST environment variable
ARG dockerhost
ENV DOCKER_HOST=$dockerhost 
