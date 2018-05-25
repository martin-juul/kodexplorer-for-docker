FROM php:7.1-fpm-alpine

LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.name="martin-juul/kodexplorer-for-docker:php-fpm7.1" \
      org.label-schema.vendor="Martin Juul" \
      org.label-schema.vcs-url="https://github.com/martin-juul/kodexplorer-for-docker"

ENV KODEXPLORER_VERSION=4.25
ENV KODEXPLORER_URL="https://github.com/kalcaddle/KodExplorer/archive/${KODEXPLORER_VERSION}.tar.gz"
ENV GID=1000

RUN set -x \
  && mkdir -p /usr/src/kodexplorer \
  && apk --update --no-cache add wget bash

RUN set -x \
  && apk add --no-cache --update \
        freetype libpng libjpeg-turbo \
        freetype-dev libpng-dev libjpeg-turbo-dev \
  && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
  && docker-php-ext-install -j "$(getconf _NPROCESSORS_ONLN)" gd \
  && apk del --no-cache freetype-dev libpng-dev libjpeg-turbo-dev

RUN set -xe \
  && echo http://dl-2.alpinelinux.org/alpine/edge/community/ >> /etc/apk/repositories \
  && apk --no-cache add shadow \
  && addgroup -g ${GID} usersharedata \
  && addgroup root usersharedata

VOLUME /var/www/html

WORKDIR /var/www/html

COPY docker-entrypoint.sh /usr/local/bin/

EXPOSE 9000

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["php-fpm"]
