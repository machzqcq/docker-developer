# Spin up ci-cd-ct stack

Starts Jenkins 2, Nexus 3, Sonarqube 5.1 and Selenium Grid 2.53  

## How  

Run the script ./copy_certs.sh. This will copy the client tls certs for the docker-machine with name 'efault' to current directory. This is so that Jenkins container can talk back to the docker-engine that launches it.

```
docker-compose build
```  

This will build Jenkins 2.0 image (The ca.pem,cert.pem,key.pem are copied to /var/jenkins_home/.docker folder)  
Open up jenkins_tls.dockerfile and see the instructions  

## Run the ci-cd-cd stack  

```
docker-compose up -d
```  

This should start all services  

## How to access  

```
docker ps
```  

This will show all port mappings between container and docker host  

## Troubleshoot

In rare scenarios - if your jenkins cannot talk to docker-daemon and complains about SSL handshake exception, then  

```
docker-machine scp ~/.docker/machine/machines/default/ca.pem default:/home/docker/.docker/
docker-machine scp ~/.docker/machine/machines/default/cert.pem default:/home/docker/.docker/
docker-machine scp ~/.docker/machine/machines/default/key.pem default:/home/docker/.docker/

```  

The above assuming that /var/jenkins_home(jenkins container)  is a mounted volume on top of /home/docker/ (on docker host)


