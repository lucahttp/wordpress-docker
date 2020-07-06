FROM ubuntu:latest


# File Author / Maintainer
LABEL maintainer="luca.sain@outlook.com"


ARG DEBIAN_FRONTEND=noninteractive

ENV TZ=America/Argentina/Buenos_Aires

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Update the repository sources list
RUN apt-get update

# Install and run apache
RUN apt-get install -y apache2 php php-mysql wget unzip zip && apt-get clean

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

RUN wget https://wordpress.org/latest.zip -O wordpress.zip

RUN unzip /var/www/html/wordpress.zip
RUN rm -rf /var/www/html/wordpress.zip

RUN usermod -a -G www-data root
RUN chown -R -f www-data:www-data /var/www/html
#RUN chmod 755 wordpress -R
#RUN chown www-data wordpress -R

#https://www.configserverfirewall.com/ubuntu-linux/install-apache-php-mysql-ubuntu-18/
# RUN mkdir /var/www/mywordpress.ga
#RUN vim /etc/apache2/sites-available/example.com.conf

#ENV APACHE_RUN_USER www-data
#ENV APACHE_RUN_GROUP www-data
#ENV APACHE_LOG_DIR /var/log/apache2


#RUN echo hostname -I

EXPOSE 80
CMD apachectl -D FOREGROUND
