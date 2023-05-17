FROM nginx:latest

ARG CONSUL_AGENT_VERSION=${CONSUL_AGENT_VERSION:-1.15.2}
ARG CONSUL_TEMPLATE_VERSION=${CONSUL_TEMPLATE_VERSION:-0.31.0}

# Tell apt-get we're never going to be able to give manual feedback
RUN export DEBIAN_FRONTEND=noninteractive

# Download latest listing of available packages and upgrade already installed packages
RUN apt-get -y update && apt-get -y upgrade


# Install wget and unzip
RUN apt install -y wget unzip
# Download consul-agent
RUN wget https://releases.hashicorp.com/consul/${CONSUL_AGENT_VERSION}/consul_${CONSUL_AGENT_VERSION}_linux_amd64.zip -P /tmp && unzip /tmp/consul_1.8.5_linux_amd64.zip -d /tmp && mv /tmp/consul /usr/local/bin/consul

# Download consul-template
RUN wget https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip -P /tmp && unzip /tmp/consul-template_0.25.1_linux_amd64.zip -d /tmp && mv /tmp/consul-template /usr/local/bin/consul-template

# Start nginx
CMD service nginx start ; while true ; do sleep 100; done;
