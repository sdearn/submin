############################################################
# Dockerfile to build Nginx Installed Containers
# Based on Centos
############################################################
# Set the base image to Centos
FROM centos:6
# File Author / Maintainer
MAINTAINER 540797670@qq.com

# set env
ENV SUBMIN_HOSTNAME 192.168.1.217
ENV SUBMIN_EXTERNAL_PORT 80
ENV SUBMIN_DATA_DIR /sumbin/data
ENV SUBMIN_SVN_DIR /submin/svn
ENV SUBMIN_ADMIN_MAIL root@submin.local


# Install
RUN yum -y install httpd subversion mod_dav_svn wget apr-util-sqlite apr-util
RUN echo 'LoadModule authn_dbd_module modules/mod_authn_dbd.so' >>/etc/httpd/conf/httpd.conf
RUN echo 'LoadModule dbd_module modules/mod_dbd.so' >>/etc/httpd/conf/httpd.conf


# Install submin
WORKDIR /usr/local/src/
RUN wget http://supermind.nl/submin/current/submin-2.2.1-1.tar.gz
RUN tar -xzvf submin-2.2.1-1.tar.gz
WORKDIR /usr/local/src/submin-2.2.1-1/
RUN python setup.py install
WORKDIR /

EXPOSE 80

ADD docker-entrypoint.sh /bin/
RUN ["chmod", "+x", "/bin/docker-entrypoint.sh"]
ENTRYPOINT ["docker-entrypoint.sh"]
