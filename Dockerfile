FROM debian:12.7-slim

ARG DEBIAN_FRONTEND=noninteractive

ENV salt_version=3006.9
ENV debian_version=12
ENV debian_codename=bookworm
ENV salt_local_key_name=salt-archive-keyring-2023.gpg
ENV salt_remote_key_name=SALT-PROJECT-GPG-PUBKEY-2023.gpg
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y curl gnupg2 procps

RUN mkdir -p /etc/apt/keyrings
RUN curl -fsSL -o /etc/apt/keyrings/${salt_local_key_name} https://repo.saltproject.io/salt/py3/debian/${debian_version}/amd64/${salt_remote_key_name}
RUN echo "deb [signed-by=/etc/apt/keyrings/${salt_local_key_name} arch=amd64] https://repo.saltproject.io/salt/py3/debian/${debian_version}/amd64/minor/${salt_version} ${debian_codename} main" | tee /etc/apt/sources.list.d/salt.list

RUN apt-get update
RUN apt-get install -y salt-master salt-minion salt-ssh salt-cloud python3-git

COPY run.sh /
RUN chmod +x /run.sh

EXPOSE 4505/tcp 4506/tcp

CMD ["/run.sh"]