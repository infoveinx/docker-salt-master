FROM debian:11.6-slim

ENV salt_version=3005.1-1
ENV debian_version=11
ENV debian_codename=bullseye

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y curl gnupg2 procps

RUN mkdir /etc/apt/keyrings
RUN curl -fsSL -o /etc/apt/keyrings/salt-archive-keyring.gpg https://repo.saltproject.io/salt/py3/debian/${debian_version}/amd64/minor/${salt_version}/salt-archive-keyring.gpg
RUN echo "deb [signed-by=/etc/apt/keyrings/salt-archive-keyring.gpg arch=amd64] https://repo.saltproject.io/salt/py3/debian/${debian_version}/amd64/minor/${salt_version} ${debian_codename} main" | tee /etc/apt/sources.list.d/salt.list

RUN apt-get update
RUN apt-get install -y salt-master salt-ssh salt-cloud python3-git

EXPOSE 4505/tcp 4506/tcp

ENTRYPOINT exec /usr/bin/salt-master --log-level=info