# SSH service as docker image

Docker image to create a container exposing a ssh service

## Install

```
$ git clone https://github.com/Soletic/hosting-docker-ubuntu.git ./ubuntu
$ git clone https://github.com/Soletic/hosting-docker-sshd.git ./sshd
$ docker build -t soletic/ubuntu ./ubuntu
$ docker build -t soletic/sshd ./sshd
```

## Run

```
$ docker run -d -p 2222:22 -v /path/host:/home --name sshd soletic/sshd
```

## Connect

```
$ ssh -p 2222 root@sshd
```