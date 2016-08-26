FROM ubuntu:14.04
MAINTAINER Dmitriy Zhernosekov <dimakievua@gmail.com>
ENV MYSQL_USER root
ENV MYSQL_PASS password
ENV APACHE_RUN_GROUP www-data
ENV APACHE_RUN_USER www-data
ENV TERM xterm
ENV DEBIAN_FRONTEND noninteractive
# Install required packages & cleanup
RUN apt-get clean all && \
    apt-get update && \
    apt-get -y dist-upgrade && \
    apt-get -y install wget mysql-server && \
    apt-get -y install apache2 php5 libapache2-mod-php5 php5-mysql php5-ldap php5-gd php-pear php-apc php5-curl php5-xdebug ruby ruby-dev libsqlite3-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
	
# Install Adminer & Composer
RUN cd ~ && \
    wget http://repo.zabbix.com/zabbix/3.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_3.0-1+trusty_all.deb && \
    dpkg -i zabbix-release_3.0-1+trusty_all.deb && \
    apt-get update && \
    apt-get -y install zabbix-server-mysql zabbix-frontend-php
# Setup PHP timezone 
# Setup PHP to use mailcatcher to send mails
# Setup PHP to display all errors
# Setup PHP: Increase size file
# Configure Xdebug
RUN echo "date.timezone=Europe/Berlin" > /etc/php5/apache2/conf.d/01-timezone.ini && \
    echo "date.timezone=Europe/Berlin" > /etc/php5/cli/conf.d/01-timezone.ini && \
    sed -i "s/upload_max_filesize = .*/upload_max_filesize = 20M/g" /etc/php5/apache2/php.ini && \
    sed -i "s/post_max_size = .*/post_max_size = 80M/g" /etc/php5/apache2/php.ini && \
    sed -i 's/# php_value/php_value/g; s/Riga/Berlin/g' /etc/apache2/conf-enabled/zabbix.conf
# Run services
RUN service apache2 restart
# && service zabbix-server restart
# service zabbix-server start
#CMD ["/usr/bin/service apache2 restart"]
