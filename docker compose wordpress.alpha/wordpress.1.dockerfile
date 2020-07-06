FROM ubuntu:latest

LABEL maintainer="luca.sain@outlook.com"

####  Installing Required Packages  ####
USER root

RUN apt-get -y update && apt-get -y upgrade

RUN apt-get -y apache2 \
	libapache2-mod-php php \
	php-mysql \
	php-bcmath \
	php-mbstring \
	php-common \
	php-gettext \
	php-xml \
	php-xmlrpc \
	php-curl \
	php-gd

#### COPYING ALL NECESSARY ITEMS  ####
#ADD wordpress /var/www/html
#ADD phpMyAdmin-4.8.4 /usr/local/phpMyAdmin
#ADD mariadb-10.3.12 /tmp/mariadb 
#ADD phpMyAdmin-4.8.4/phpmyadmin.conf /etc/apache2/conf-enabled/phpmyadmin.conf
#ADD mariadb-10.3.12/my.cnf /etc/my.cnf
#ADD scripts/mariadb.sh /tmp/db.sh
#ADD scripts/wp_db.sh /tmp/wp_db.sh
#ADD scripts/command.sh /bin/cmd
#ADD scripts/perm.sh /tmp/perm.sh


#### Final Command To Run ####
EXPOSE 80 3306
CMD ["/bin/cmd"]