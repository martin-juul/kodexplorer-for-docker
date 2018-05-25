#!/usr/bin/env bash

set -e

if [ "$1" = 'php' ] && [ "$(id -u)" = '0' ]; then
    chown -R www-data /var/www/html
    chmod -R 777 /var/www/html/
fi

if [ ! -f /var/www/html/index.php ]; then
  wget -O /tmp/kodexplorer.tar.gz "${KODEXPLORER_URL}" \
  && tar -xzf /tmp/kodexplorer.tar.gz -C /usr/src/kodexplorer/ --strip-components=1 \
  && rm -rf /tmp/*
fi

if [ ! -e '/var/www/html/index.php' ]; then
    cp -a /usr/src/kodexplorer/* /var/www/html/
fi

exec "$@"
