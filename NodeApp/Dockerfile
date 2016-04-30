# This dockerfile is used to build rebates-offermanager-spa
# docker build -t  "pradeep/NodeApp" -f Dockerfile .
# Pull base image
FROM node:4.4-wheezy
# Maintainer
MAINTAINER pradeep.macharla@inmar.com
# Expose ports
EXPOSE 80 443 3000

RUN apt-get update && apt-get install -y wget
RUN wget https://github.com/jwilder/dockerize/releases/download/v0.2.0/dockerize-linux-amd64-v0.2.0.tar.gz
RUN tar -C /usr/local/bin -xzvf dockerize-linux-amd64-v0.2.0.tar.gz


# Install git client and clone repo
RUN apt-get update && apt-get install -y git curl wget procps && \
    git clone https://github.com/machzqcq/docker-developer.git
# Change git:// to https:// as sometimes firewall seems to block git
RUN git config --global url."https://".insteadOf git://
# Run npm install to get all dependencies
WORKDIR docker-developer/NodeApp
RUN npm install

# Define default command and wait until db is started
CMD dockerize -wait tcp://db:5432 npm start
