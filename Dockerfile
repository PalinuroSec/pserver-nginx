# vim:set ft=dockerfile:
FROM debian:9
MAINTAINER Lorenzo "Palinuro" Faletra (palinuro@linux.it)
ENV DEBIAN_FRONTEND noninteractive
ENV VERSION 0.3

# Prepare environment
RUN echo "deb http://deb.debian.org/debian stretch-backports main\ndeb http://deb.debian.org/debian buster main" >> /etc/apt/sources.list &&\
	echo "Package: php* libphp*\nPin: release a=testing\nPin-Priority: 750" > /etc/apt/preferences &&\
	apt update && apt -y dist-upgrade &&\
	rm -rf /var/lib/apt/lists/*

# Install additional components
RUN apt update && \
		apt install -y nginx &&\
		apt install -y  php7.2-fpm php7.2-curl php7.2-gd \
						php7.2-mbstring php7.2-json php7.2-mysql php7.2-xml \
						php7.2-cli \
		&& rm -rf /var/lib/apt/lists/*
COPY nginx-config /nginx-config
RUN cat /nginx-config > /etc/nginx/sites-enabled/default


VOLUME ["/var/www/html/", "/var/log/nginx/"]

EXPOSE 80
STOPSIGNAL SIGTERM
CMD service php7.2-fpm start && nginx -g "daemon off;"
