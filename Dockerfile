FROM ubuntu:trusty
MAINTAINER Sol&TIC <serveur@soletic.org>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y openssh-server supervisor 
RUN apt-get install -y pwgen

# Useful toos to deploy strategy
RUN apt-get install -y git curl wget

RUN mkdir /var/run/sshd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin no/' /etc/ssh/sshd_config
RUN sed -i 's/#AuthorizedKeysFile/AuthorizedKeysFile/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

VOLUME ["/var/log", "/home"]

ADD supervisor-sshd.conf /etc/supervisor/conf.d/supervisor-sshd.conf
ADD run.sh /run.sh

# MAKE SCRIPT EXCUTABLE
RUN chmod 755 /*.sh

EXPOSE 22
CMD ["/run.sh"]