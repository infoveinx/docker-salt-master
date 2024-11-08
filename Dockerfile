FROM debian:12.7-slim

ARG DEBIAN_FRONTEND=noninteractive

<<<<<<< HEAD
ENV salt_version=3006.9
=======
ENV salt_version=3007.1
>>>>>>> 3007.1
ENV debian_version=12
ENV debian_codename=bookworm
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y curl gnupg2 procps

RUN mkdir -p /etc/apt/keyrings
RUN curl -fsSL -o /etc/apt/keyrings/salt-archive-keyring.pgp https://packages.broadcom.com/artifactory/api/security/keypair/SaltProjectKey/public
RUN curl -fsSL -o/etc/apt/sources.list.d/salt.sources https://github.com/saltstack/salt-install-guide/releases/latest/download/salt.sources
RUN printf "Package: salt-*\nPin: version ${salt_version}\nPin-Priority: 1001\n" > /etc/apt/preferences.d/salt-pin-1001

RUN apt-get update
RUN apt-get install -y salt-master salt-minion salt-ssh salt-cloud python3-git

COPY run.sh /
RUN chmod +x /run.sh

EXPOSE 4505/tcp 4506/tcp

CMD ["/run.sh"]