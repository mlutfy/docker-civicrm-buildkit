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

# Avoid Apache complaint about server name
RUN echo "ServerName civicrm-buildkit" > /etc/apache2/conf-available/civicrm-buildkit.conf
RUN a2enconf civicrm-buildkit 

# Drupal requires mod rewrite.
RUN a2enmod rewrite

# We don't want to ever send email. But we also don't want an error when 
# Drupal or CiviCRM tries
RUN ln -s /bin/true /usr/sbin/sendmail

# Give ssh access via key
RUN usermod -s /bin/bash www-data
RUN echo 'export PATH=/var/www/civicrm/civicrm-buildkit/bin:$PATH' > /var/www/.profile

RUN mkdir /var/www/civicrm

# Ensure www-data owns it's home directory so amp will work.
RUN chown -R www-data:www-data /var/www

# Allow www-data user to restart apache
RUN echo "www-data ALL=NOPASSWD: /usr/bin/sv restart apache, /usr/bin/sv reload apache, /usr/sbin/apache2ctl" > /etc/sudoers.d/civicrm-buildkit

## Allow www-data to run mysql cli tools
RUN echo "[client]" > /var/www/.my.cnf ; echo "user=root" >> /var/www/.my.cnf

COPY build.sh /build.sh
RUN /build.sh

CMD ["/usr/sbin/apache2ctl", "-DFOREGROUND"]
