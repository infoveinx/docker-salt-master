FROM debian:10.9-slim

ENV salt_version=3003
ENV debian_version=10

RUN apt-get update
RUN apt-get install -y wget gnupg2

RUN wget -O - https://repo.saltstack.com/py3/debian/${debian_version}/amd64/archive/${salt_version}/SALTSTACK-GPG-KEY.pub | apt-key add -
RUN echo "deb http://repo.saltstack.com/py3/debian/${debian_version}/amd64/archive/${salt_version} buster main" > /etc/apt/sources.list.d/saltstack.list

RUN apt-get update
RUN apt-get install -y salt-master salt-ssh salt-cloud python3-git

ADD run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

EXPOSE 4505/tcp 4506/tcp

ENTRYPOINT ["/usr/local/bin/run.sh"]
