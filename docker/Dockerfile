# base image
FROM centos

# MAINTAINER
MAINTAINER 540797670@qq.com

# put nginx-1.12.2.tar.gz into /usr/local/src and unpack nginx
RUN yum -y install  wget
WORKDIR /usr/local/src
RUN wget http://nginx.org/download/nginx-1.12.2.tar.gz
RUN tar -xzvf nginx-1.12.2.tar.gz

# running required command
RUN yum install -y gcc gcc-c++ glibc make autoconf openssl openssl-devel 
RUN yum install -y libxslt-devel -y gd gd-devel GeoIP GeoIP-devel pcre pcre-devel
RUN useradd -M -s /sbin/nologin nginx

# mount a dir to container
ONBUILD VOLUME ["/data"]

# change dir to /usr/local/src/nginx-1.12.2
WORKDIR /usr/local/src/nginx-1.12.2

# execute command to compile nginx
RUN ./configure --user=nginx --group=nginx --prefix=/usr/local/nginx --with-file-aio  --with-http_ssl_module  --with-http_realip_module    --with-http_addition_module    --with-http_xslt_module   --with-http_image_filter_module    --with-http_geoip_module  --with-http_sub_module  --with-http_dav_module --with-http_flv_module    --with-http_mp4_module --with-http_gunzip_module  --with-http_gzip_static_module  --with-http_auth_request_module  --with-http_random_index_module   --with-http_secure_link_module   --with-http_degradation_module   --with-http_stub_status_module && make && make install

# setup PATH
ENV PATH /usr/local/nginx/sbin:$PATH

# EXPOSE
EXPOSE 80

# the command of entrypoint
ENTRYPOINT ["nginx"]

CMD ["-g"]
