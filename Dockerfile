FROM debian:10.10-slim

ENV salt_version=3003.1
ENV debian_version=10

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y curl gnupg2 procps

RUN curl -fsSL -o /usr/share/keyrings/salt-archive-keyring.gpg https://repo.saltproject.io/py3/debian/${debian_version}/amd64/archive/${salt_version}/salt-archive-keyring.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/salt-archive-keyring.gpg] https://repo.saltproject.io/py3/debian/${debian_version}/amd64/archive/${salt_version} buster main" | tee /etc/apt/sources.list.d/salt.list

RUN apt-get update
RUN apt-get install -y salt-master salt-ssh salt-cloud python3-git

EXPOSE 4505/tcp 4506/tcp

ENTRYPOINT exec /usr/bin/salt-master --log-level=info