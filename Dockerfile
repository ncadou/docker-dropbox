# Dropbox client

FROM debian:jessie
MAINTAINER Nicolas Cadou <ncadou@cadou.ca>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y wget && \
    apt-get clean

# Using wget because an ADD step with a URL isn't cached by docker build.
RUN wget -O /dropbox.tgz https://www.dropbox.com/download?plat=lnx.x86_64
RUN tar zxf /dropbox.tgz -C /usr/local && \
    mv /usr/local/.dropbox-dist /usr/local/dropbox-dist && \
    ln -s /usr/local/dropbox-dist/dropboxd /usr/local/bin && \
    rm /dropbox.tgz

RUN useradd -m dropbox
USER dropbox
ENV HOME /home/dropbox
WORKDIR /home/dropbox

RUN mkdir -p Dropbox config/dropbox config/dropbox-master && \
    chown -R dropbox:dropbox Dropbox config && \
    ln -s config/dropbox .dropbox && \
    ln -s config/dropbox-master .dropbox-master

VOLUME ["/home/dropbox/config", "/home/dropbox/Dropbox"]

CMD ["/usr/local/bin/dropboxd"]
