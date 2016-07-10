
# RVM in a jenkins slave container
This is used as a jenkins slave to run Ruby tests

## Usage
```
$ docker build -t "myrvm" -f rvm_jenkins_slave.dockerfile .
$ docker run -d myrvm
```
