#!/bin/bash

CONSUL_ADDR=${CONSUL_ADDR:-consul:8500}
# Start Consul agent in the background
consul agent -config-dir=/etc/consul.d/ -bind=$(ip -o -4 addr list $CONSUL_BIND_INTERFACE | head -n1 | awk '{print $4}' | cut -d/ -f1) &

# Start Consul-Template in the background
consul-template -consul-addr=${CONSUL_ADDR} -template="${NGINX_CTMPL}:/etc/nginx/nginx.conf:service nginx reload" &

# Start Nginx in the foreground
nginx -g 'daemon off;'
