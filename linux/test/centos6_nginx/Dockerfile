# Dockerfile for testing the OMERO Linux installation instructions
# Not intended for production use
FROM centos:centos6
MAINTAINER ome-devel@lists.openmicroscopy.org.uk

ARG WEBSESSION=false
ARG WEBAPPS=false
ARG OMEROVER=latest
ARG JAVAVER=openjdk18
ARG ICEVER=ice35
ARG PGVER=pg94

# Needed for postgres init.d
RUN touch /etc/sysconfig/network

# Get cron working http://stackoverflow.com/a/21928878
RUN yum -y install cronie && \
	sed -i -re s'/(session\s+required\s+pam_loginuid.so)/#\1/' \
	/etc/pam.d/crond

ADD omero-install-test.zip /
RUN yum -y install unzip && unzip omero-install-test.zip

RUN cd omero-install-test && \
	bash install_centos6_nginx.sh && \
	PGVER=${PGVER} bash docker_shutdown_centos6.sh
ADD run.sh /home/omero/run.sh

EXPOSE 80 4063 4064
ENTRYPOINT ["/bin/bash", "-e", "/home/omero/run.sh"]