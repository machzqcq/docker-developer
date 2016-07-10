# Docker file for Ubuntu with RVM
# docker build -t "myrvm" -f rvm_test.dockerfile .
FROM ubuntu:14.04

MAINTAINER Pradeep Macharla <pradeep@seleniumframework.com> 

#Enable as jenkins slave
# Install a basic SSH server
RUN apt-get update && \
    apt-get install -y openssh-server curl tar vim git
RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd
RUN mkdir -p /var/run/sshd

RUN apt-get install -y openjdk-7-jdk

# Add user jenkins to the image
RUN useradd -m jenkins  -s /bin/bash -p jenkins
RUN groupadd rvm
RUN usermod -G rvm,sudo jenkins
# Set password for the jenkins user (you may want to alter this).
RUN echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Install RVM and add to jenkins profile

RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
RUN \curl -sSL https://get.rvm.io | bash -s stable --ruby=2.0
RUN echo 'gem: --no-ri --no-rdoc' > ~/.gemrc
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"
RUN echo "source /usr/local/rvm/scripts/rvm" >> /home/jenkins/.bash_profile
RUN echo "source /usr/local/rvm/scripts/rvm" >> /home/jenkins/.profile


# Standard SSH port
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]


 
