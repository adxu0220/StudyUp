#!/usr/bin/env bash

set -e

if [ -z "$PROXY_PORT" ]; then
export PROXY_PORT=8888
fi

if [ $1 -eq "redis" ]; then
export REDIS_HOST=redis
else
export REDIS_HOST=$1
fi

if [ -z "$REDIS_PORT" ]; then
export REDIS_PORT=6379
elif [[ "$REDIS_PORT" =~ "tcp://" ]]; then
export REDIS_PORT=6379
fi



sed -i -E "s/server.+;/server ${REDIS_HOST}:${REDIS_PORT} ;/" /etc/nginx/nginx.conf
exec /usr/sbin/nginx -s reload


if [ "${REDIS_HOST}" == "34.73.56.224" ]; then
# see shared database
fi




sed -i'' "s/%{PROXY_PORT}/${PROXY_PORT}/" /etc/nginx/nginx.conf
sed -i'' "s/%{REDIS_HOST}/${REDIS_HOST}/" /etc/nginx/nginx.conf
sed -i'' "s/%{REDIS_PORT}/${REDIS_PORT}/" /etc/nginx/nginx.conf

exec "$@"

