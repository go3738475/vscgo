FROM ubuntu:22.04

# Tell debconf to run in non-interactive mode
ENV DEBIAN_FRONTEND noninteractive


RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    pkg-config \
    curl \
    wget \
    git \
    gnupg \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Add the vscode debian repo
RUN curl -sSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | apt-key add -
RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list

RUN apt-get update && apt-get -y install \
    code \
    protobuf-compiler \
    openssh-client \
    build-essential \
    tree \
    && rm -rf /var/lib/apt/lists/*

ENV HOME /home/user
RUN useradd --create-home --home-dir $HOME user \
    && chown -R user:user $HOME

ENV GOVER 1.22.0
RUN wget https://golang.org/dl/go${GOVER}.linux-amd64.tar.gz; \
tar -C /usr/local -xzf go${GOVER}.linux-amd64.tar.gz; \
rm go${GOVER}.linux-amd64.tar.gz;

COPY start.sh /usr/local/bin/start.sh

EXPOSE 3000

WORKDIR $HOME

CMD [ "start.sh" ]