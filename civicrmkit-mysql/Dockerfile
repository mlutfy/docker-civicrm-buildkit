FROM debian:jessie
MAINTAINER Jamie McClelland <jamie@progressivetech.org>
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
  apt-get install -y \
  php5-mysql \
  mysql-server \
  mysql-client \
  bzip2 \
  libapache2-mod-php5 \
  runit \
  git \
  lsb-release \
  acl \
  wget \
  unzip \
  php5-cli \
  php5-imap \
  php5-ldap \
  php5-curl \
  php5-intl \
  php5-gd \
  nodejs \
  sudo \
  vim \
  npm \
  php5-mcrypt \
  apache2 \
  nodejs-legacy \
  ruby\
  rake

# Avoid key buffer size warnings and myisam-recover warnings
# See: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=751840
RUN sed -i "s/^key_buffer\s/key_buffer_size\t/g" /etc/mysql/my.cnf
RUN sed -i "s/^myisam-recover\s/myisam-recover-options\t/g" /etc/mysql/my.cnf


# Handle service starting with runit.
RUN mkdir /etc/sv/mysql
COPY mysql.run /etc/sv/mysql/run
RUN update-service --add /etc/sv/mysql

## Allow www-data to run mysql cli tools
RUN echo "[client]" > /var/www/.my.cnf ; echo "user=root" >> /var/www/.my.cnf

# expose the mysql port to "docker ps"
EXPOSE 3306

VOLUME /var/lib/mysql
VOLUME /var/log/mysql

COPY setup.sh /setup.sh
RUN chmod +x /setup.sh

# RUN /entrypoint.sh
CMD ["/setup.sh"]
