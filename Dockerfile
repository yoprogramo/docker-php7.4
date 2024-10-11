FROM ubuntu:22.04
ENV DEBIAN_FRONTEND noninteractive
# Install basics
RUN apt-get update
RUN apt-get install -y software-properties-common && \
 add-apt-repository ppa:ondrej/php && apt-get update
RUN apt-get install -y --force-yes curl
# Install PHP (latest) 
RUN apt-get install -y --allow-unauthenticated php7.4 php7.4-mysql php7.4-cli php7.4-gd php7.4-curl php7.4-xml php7.4-mbstring php7.4-imap
RUN apt-get install -y libfontconfig1 libxrender1 libxtst6 libxi6
# Install mysql para actualizaciones
RUN apt update -y
RUN apt install -y mysql-client
RUN update-alternatives --set php /usr/bin/php7.4

# Enable apache mods.
RUN a2enmod php7.4
RUN a2enmod rewrite
# Update the PHP.ini file.
COPY php.ini /etc/php/7.4/apache2/php.ini
RUN sed -i "s/error_reporting = .*$/error_reporting = E_ERROR | E_WARNING | E_PARSE/" /etc/php/7.4/apache2/php.ini
# Manually set up the apache environment variables
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
# Expose apache.
EXPOSE 80
EXPOSE 443

# Update the default apache site with the config we created.
ADD apache-config.conf /etc/apache2/sites-enabled/000-default.conf
ADD php.ini /etc/php/7.4/apache2/php.ini
# By default start up apache in the foreground, override with /bin/bash for interative.
CMD /usr/sbin/apache2ctl -D FOREGROUND
