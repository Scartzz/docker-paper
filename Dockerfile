FROM nimmis/java:openjdk-8-jdk

MAINTAINER scartz <admin@scarx.net>

ENV PAPER_HOME=/minecraft \
    PAPER_VER=latest \
    PAPER_AUTORESTART=yes

# add extra files needed
COPY rootfs /

RUN apt-get update && \

    # upgrade OS
    apt-get -y dist-upgrade && \

    # Make info file about this build
    printf "Build of scartz/docker-paper:latest, date: %s\n"  `date -u +"%Y-%m-%dT%H:%M:%SZ"` > /etc/BUILDS/paper && \

    # install application
    apt-get install -y wget git && \

    # Make special user for minecraft to run in
    /usr/sbin/useradd -s /bin/bash -d /minecraft -m minecraft && \

    # remove apt cache from image
    apt-get clean all


# expose minecraft port
EXPOSE 25565


