ARG NGINX_VERSION=${NGINX_VERSION:-latest}
#ARG CONSUL_AGENT_VERSION=${CONSUL_AGENT_VERSION:-1.15.2}
#ARG CONSUL_TEMPLATE_VERSION=${CONSUL_TEMPLATE_VERSION:-0.31.0}
# Use the official nginx image as base
FROM nginx:$NGINX_VERSION

# Set the versions of Consul and Consul-Template to install
ENV CONSUL_VERSION=1.15.2
ENV CONSUL_TEMPLATE_VERSION=0.31.0


ENV NGINX_CTMPL=/etc/consul-template/nginx.ctmpl


# Update and install necessary packages
RUN apt-get update && apt-get install -y curl unzip iproute2

# Install Consul
RUN curl -fsSL https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip -o consul.zip \
    && unzip consul.zip \
    && mv consul /usr/local/bin/ \
    && rm consul.zip

# Install Consul-Template
RUN curl -fsSL https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip -o consul-template.zip \
    && unzip consul-template.zip \
    && mv consul-template /usr/local/bin/ \
    && rm consul-template.zip

# Clean up
RUN apt-get remove --purge -y curl unzip \
    && apt-get autoremove -y \
    && apt-get clean

#Copy consul configuration files
COPY consul-template /etc/consul

# Add entrypoint script
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose the Consul ports and nginx port
EXPOSE 8300 8301 8301/udp 8302 8302/udp 8400 8500 8600 8600/udp 80


# Run entrypoint script
CMD ["/entrypoint.sh"]
