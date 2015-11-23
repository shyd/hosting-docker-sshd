FROM soletic/ubuntu
MAINTAINER Sol&TIC <serveur@soletic.org>

RUN apt-get update && \
  apt-get install -y openssh-server && \
  apt-get install -y pwgen git curl wget

ENV WORKER_NAME ""
ENV WORKER_UID 10001

RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin no/' /etc/ssh/sshd_config
RUN sed -i 's/#AuthorizedKeysFile/AuthorizedKeysFile/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

VOLUME ["/var/log", "/home"]

ADD supervisor-sshd.conf /etc/supervisor/conf.d/supervisor-sshd.conf
ADD run.sh /root/scripts/sshd.sh
RUN chmod 755 /root/scripts/*.sh

EXPOSE 22