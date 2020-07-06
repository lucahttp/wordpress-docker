FROM ubuntu:latest

LABEL maintainer="luca.sain@outlook.com"

## seteando lenguaje
#ENV OS_LOCALE="es_AR.UTF-8"
#RUN apt-get update && apt-get install -y locales && locale-gen ${OS_LOCALE}
#ENV LANG=${OS_LOCALE} \
#    LANGUAGE=${OS_LOCALE} \
#    LC_ALL=${OS_LOCALE} \
#    DEBIAN_FRONTEND=noninteractive


ARG DEBIAN_FRONTEND=noninteractive

ENV TZ=America/Argentina/Buenos_Aires

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Update the repository sources list
RUN apt-get update


# Install and run apache
RUN apt-get install -y apache2 php php-mysql wget unzip zip && apt-get clean


RUN rm -R /var/www/html/*

RUN	chown www-data:www-data /var/www/html/ -Rf



RUN mv -v /var/www/html/* /var/www/html/


# WORKDIR /var/www/html/

EXPOSE 80 443

# By default, simply start apache.
CMD apachectl -D FOREGROUND
