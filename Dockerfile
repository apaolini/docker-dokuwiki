# BUILD:       docker build -t apaolini/dokuwiki .
# RUN:         docker run -d -p 8080:80 apaolini/dokuwiki

# Inspired from mprasil/dokuwiki

FROM ubuntu:14.04
MAINTAINER Andrea Paolini <ap@nuxi.it>

# Dokuwiki Version
ENV DOKUWIKI_VERSION  2016-06-26

# Install lighttpd and PHP
RUN  apt-get update \
  && apt-get -y upgrade \
  && apt-get -y install lighttpd php5-cgi php5-gd curl \
  && apt-get clean \
  && rm -rf /var/lib/{apt,dpkg,cache,log}

# Get and deploy dokuwiki
RUN curl -s -o /dokuwiki.tgz "http://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz" \
  && cd /var/www/ \
  && tar -zxf /dokuwiki.tgz \
  && mv dokuwiki-${DOKUWIKI_VERSION} dokuwiki \
  && rm /dokuwiki.tgz \
  && chown -R www-data:www-data /var/www/dokuwiki

# Configure lighttpd
RUN mkdir /var/run/lighttpd/ && chown www-data:www-data /var/run/lighttpd/ \
  && cd /etc/lighttpd/conf-enabled \
  && ln -s ../conf-available/10-fastcgi.conf     . \
  && ln -s ../conf-available/15-fastcgi-php.conf .

# Config for dokuwiki/docker
RUN sed -ie 's/^server.errorlog\(.*\)$/#server.errorlog\1/' /etc/lighttpd/lighttpd.conf
ADD 99-dokuwiki.conf /etc/lighttpd/conf-enabled

EXPOSE 80

VOLUME ["/var/www/dokuwiki/conf/", "/var/www/dokuwiki/data/","/var/www/dokuwiki/lib/plugins/","/var/www/dokuwiki/lib/tpl/"]

ENTRYPOINT ["/usr/sbin/lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]
