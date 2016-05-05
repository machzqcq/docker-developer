# Docker file for CentOS with RVM
FROM ubuntu:14.04


#Enable as jenkins slave
# Install a basic SSH server
RUN apt-get update && \
    apt-get install -y openssh-server curl tar vim git
RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd
RUN mkdir -p /var/run/sshd

RUN apt-get install -y openjdk-7-jdk

# Add user jenkins to the image
RUN useradd -m jenkins  -s /bin/bash -p jenkins
# Set password for the jenkins user (you may want to alter this).
RUN echo "jenkins:jenkins" | chpasswd

# Standard SSH port
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]


RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
RUN \curl -sSL https://get.rvm.io | bash -s stable --ruby=2.0
RUN echo "source /usr/local/rvm/scripts/rvm" >> /home/jenkins/.bash_profile
RUN chown -R jenkins:jenkins /home/jenkins/.bash_profile
RUN chown -R jenkins:jenkins /usr/local/rvm
 
