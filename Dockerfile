# Dockerfile for Apache Storm
# https://github.com/sogos/DockerKafka/
# Bump to 2.9.1

FROM debian:wheezy

MAINTAINER Thibault Cordier

ENV master false

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq update && apt-get -qqy upgrade && apt-get -qqy install --no-install-recommends curl bash supervisor procps sudo ca-certificates openjdk-7-jre-headless openssh-client mysql-client pwgen && apt-get clean

ADD http://mir2.ovh.net/ftp.apache.org/dist/storm/apache-storm-0.9.3/apache-storm-0.9.3.tar.gz /tmp/apache-storm-0.9.3.tar.gz
RUN mkdir -p /opt/storm
RUN cd /opt/storm && tar -xvf /tmp/apache-storm-0.9.3.tar.gz --strip 1
RUN rm -f /tmp/apache-storm-0.9.3.tar.gz
ADD storm.yaml /opt/storm/conf/storm.yaml 

# Supervisor
RUN mkdir -p /var/log/supervisor && mkdir -p /opt/supervisor
ADD storm-master.conf /etc/supervisor/conf.d/storm-master.tmp
ADD storm-worker.conf /etc/supervisor/conf.d/storm-worker.tmp
ADD run.sh /bin/run
RUN chmod +x /bin/run

ENTRYPOINT ["/bin/run"]
EXPOSE 8080 6627
