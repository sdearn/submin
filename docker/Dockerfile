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
RUN yum -y install httpd subversion mod_dav_svn wget apr-util-sqlite apr-util sudo git openssl openssh-server
RUN yum -y install sudo git openssl openssh-server sendmail mailx
RUN echo 'LoadModule authn_dbd_module modules/mod_authn_dbd.so' >>/etc/httpd/conf/httpd.conf
RUN echo 'LoadModule dbd_module modules/mod_dbd.so' >>/etc/httpd/conf/httpd.conf

RUN ssh-keygen -q -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -N ''
RUN ssh-keygen -q -t dsa -f /etc/ssh/ssh_host_dsa_key -N ''
RUN sed -i "s/#RSAAuthentication.*/RSAAuthentication yes/g" /etc/ssh/sshd_config
RUN sed -i "s/#PubkeyAuthentication.*/PubkeyAuthentication yes/g" /etc/ssh/sshd_config
RUN sed -i "s/#AuthorizedKeysFile.*/AuthorizedKeysFile \%h\/\.ssh\/authorized_keys/g" /etc/ssh/sshd_config


# Install submin
WORKDIR /usr/local/src/
RUN wget http://supermind.nl/submin/current/submin-2.2.1-1.tar.gz
RUN tar -xzvf submin-2.2.1-1.tar.gz
WORKDIR /usr/local/src/submin-2.2.1-1/
RUN python setup.py install
WORKDIR /

EXPOSE 80
EXPOSE 22

ADD docker-entrypoint.sh /bin/
RUN ["chmod", "+x", "/bin/docker-entrypoint.sh"]
ENTRYPOINT ["docker-entrypoint.sh"]
