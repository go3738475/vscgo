# Visual Studio Code in a container
#	NOTE: Needs the redering device (yeah... idk)
#
# docker run -d \
#    -v /tmp/.X11-unix:/tmp/.X11-unix \
#    -v $HOME:/home/user \
#    -e DISPLAY=unix$DISPLAY \
#    --device /dev/dri \
#    --name vscode \
#    jess/vscode

FROM debian:buster-slim
LABEL maintainer "Jessie Frazelle <jess@linux.com>"

# Tell debconf to run in non-interactive mode
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    --no-install-recommends

# Add the vscode debian repo
RUN curl -sSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | apt-key add -
RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list

RUN apt-get update && apt-get -y install \
    code \
    git \
    libasound2 \
    libatk1.0-0 \
    libcairo2 \
    libcups2 \
    libexpat1 \
    libfontconfig1 \
    libfreetype6 \
    libgtk2.0-0 \
    libpango-1.0-0 \
    libx11-xcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxi6 \
    libxrandr2 \
    libxrender1 \
    libxss1 \
    libxtst6 \
    libxcb-dri3-0 \
    openssh-client \
    wget \
    build-essential \
    apache2-utils \
    mc \
    tree \
    nodejs \
    npm \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

ENV HOME /home/user
RUN useradd --create-home --home-dir $HOME user \
    && chown -R user:user $HOME

RUN wget https://golang.org/dl/go1.15.7.linux-amd64.tar.gz; \
tar -C /usr/local -xzf go1.15.7.linux-amd64.tar.gz; \
rm go1.15.7.linux-amd64.tar.gz;

COPY start.sh /usr/local/bin/start.sh

EXPOSE 3000 80 8000
EXPOSE 8100-8200

WORKDIR $HOME

CMD [ "start.sh" ]