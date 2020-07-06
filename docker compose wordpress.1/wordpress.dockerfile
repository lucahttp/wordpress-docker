FROM ubuntu:latest


# File Author / Maintainer
LABEL author="lukaneco"
LABEL maintainer="luca.sain@outlook.com"


ARG DEBIAN_FRONTEND=noninteractive

ENV TZ=America/Argentina/Buenos_Aires

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Update the repository sources list
RUN apt-get update


# Update the repository sources list
# RUN apt-get update

# Install and run apache
RUN apt-get install -y apache2 php php-mysql wget unzip zip && apt-get clean


# delete all file of the html folder
RUN rm -R /var/www/html/*

# set permisions on the html folder
RUN	chown www-data:www-data /var/www/html/ -Rf

#ENTRYPOINT ["/usr/sbin/apache2", "-k", "start"]
#RUN service apache2 restart


# https://projects.raspberrypi.org/en/projects/lamp-web-server-with-wordpress/4
# https://pimylifeup.com/raspberry-pi-wordpress/

#RUN cd /var/www/html
#RUN wget http://wordpress.org/latest.tar.gz
#RUN tar xzf latest.tar.gz
#RUN mv wordpress/* ./
#RUN rm -rf wordpress latest.tar.gz
#RUN usermod -a -G www-data pi
#RUN chown -R -f www-data:www-data /var/www/html



# https://raspberrytips.com/wordpress-on-raspberry-pi/
# RUN wget https://wordpress.org/latest.zip -O /var/www/html/wordpress.zip



WORKDIR /var/www/html/

# download wordpress.zip
RUN wget https://wordpress.org/latest.zip -O wordpress.zip

# unzip wordpress.zip
RUN unzip /var/www/html/wordpress.zip
# delete wordpress.zip
RUN rm -rf /var/www/html/wordpress.zip

# move all files from wordpress temp directory to /var/www/html/
RUN mv -v /var/www/html/wordpress/* /var/www/html/

# delete wordpress temp directory
RUN rmdir /var/www/html/wordpress/

RUN usermod -a -G www-data root
RUN chown -R -f www-data:www-data /var/www/html

# RUN	chown www-data:www-data /var/www/html/ -Rf




#RUN chmod 755 wordpress -R
#RUN chown www-data wordpress -R

#https://www.configserverfirewall.com/ubuntu-linux/install-apache-php-mysql-ubuntu-18/
# RUN mkdir /var/www/mywordpress.ga
#RUN vim /etc/apache2/sites-available/example.com.conf

#ENV APACHE_RUN_USER www-data
#ENV APACHE_RUN_GROUP www-data
#ENV APACHE_LOG_DIR /var/log/apache2


# https://stackoverflow.com/questions/6233398/download-and-insert-salt-string-inside-wordpress-wp-config-php-with-bash
# RUN cat wp-config.php | sed 's/old_string/new_string/g' > wp-config.php


# ARG DB_NAME="db"
# ENV DB_NAME=$DB_NAME
# ENV VARIABLE_FOR_DOCKER_COMPOSE_1=yet_another_value


# https://stackoverflow.com/questions/47942016/add-bind-mount-to-dockerfile-just-like-volume
ENV DB_NAME="db"
RUN cat wp-config.php | sed 's/database_name_here/"${DB_NAME}"/g' > wp-config.php

ENV DB_USER="admin"
RUN cat wp-config.php | sed 's/username_here/"${DB_USER}"/g' > wp-config.php

ENV DB_PASSWORD=""
RUN cat wp-config.php | sed 's/password_here/"${DB_PASSWORD}"/g' > wp-config.php

ENV DB_HOST="localhost"
RUN cat wp-config.php | sed 's/localhost/"${DB_HOST}"/g' > wp-config.php
#RUN echo hostname -I

# WORKDIR /var/www/html/

EXPOSE 80
EXPOSE 443

# By default, simply start apache.
CMD apachectl -D FOREGROUND