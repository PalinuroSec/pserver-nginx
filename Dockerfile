# vim:set ft=dockerfile:
FROM debian:9
MAINTAINER Lorenzo "Palinuro" Faletra (palinuro@linux.it)
ENV DEBIAN_FRONTEND noninteractive
ENV VERSION 0.1

# Prepare environment
RUN echo "deb http://deb.debian.org/debian stretch-backports main" >> /etc/apt/sources.list &&\
	apt update && apt -y dist-upgrade &&\
	rm -rf /var/lib/apt/lists/*

# Install additional components
RUN apt update && \
		apt install -y nginx &&\
		apt install -t stretch-backports php7.0-fpm php7.0-curl php7.0-gd \
						php7.0-mbstring php7.0-json php7.0-mysql php7.0-xml \
						php7.0-cli \
		&& rm -rf /var/lib/apt/lists/*
COPY nginx-config /nginx-config
RUN cat /nginx-config > /etc/nginx/sites-enabled/default


VOLUME ["/var/www/html/", "/var/log/nginx/"]

EXPOSE 80
STOPSIGNAL SIGTERM
CMD ["nginx", "-g", "daemon off;"]
