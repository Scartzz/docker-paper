FROM nimmis/java:openjdk-8-jdk

MAINTAINER scartz <admin@scarx.net>

ENV PAPER_HOME=/minecraft \
    PAPER_AUTORESTART=yes

# add extra files needed
COPY rootfs /
RUN chmod +x -R /etc/my_runalways/
RUN chmod -x /etc/my_runalways/.ignore

RUN apt-get update

# upgrade OS
RUN apt-get -y dist-upgrade

# Make info file about this build
RUN printf "Build of scartz/docker-paper:latest, date: %s\n"  `date -u +"%Y-%m-%dT%H:%M:%SZ"` > /etc/BUILDS/paper

# install application
RUN apt-get install -y wget git maven

RUN git config --global user.email "ignored@ignored.com"
RUN git config --global user.name "ignored"

# Make special user for minecraft to run in
RUN /usr/sbin/useradd -s /bin/bash -d /minecraft -m minecraft

# remove apt cache from image
RUN apt-get clean all

# expose minecraft port
EXPOSE 25565


