# SSH service as docker image

Docker image to create a container exposing a ssh service

## Install

```
$ git clone https://github.com/shyd/docker-sshd.git ./sshd
$ docker build -t shyd/sshd ./sshd
```

## Run

```
$ docker run -d -p 2222:22 -v /path/host:/home --name sshd shyd/sshd
```

## Connect

```
$ ssh -p 2222 root@sshd
```
