# Start from an Ubuntu image
FROM ubuntu:20.04

# Avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update system and install necessary packages
RUN apt-get update && apt-get install -y \
  wget \
  gpg \
  coreutils \
  lsb-release \
  software-properties-common \
  apt-transport-https \
  && rm -rf /var/lib/apt/lists/*

# Add the HashiCorp GPG key
RUN wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

# Add the official HashiCorp Linux repository
RUN echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list

# Update and install Nomad
RUN apt-get update && apt-get install -y nomad

# Expose the necessary ports
EXPOSE 4646 4647 4648 4648/udp

# Create Nomad data directory
RUN mkdir -p /var/lib/nomad

# Create Nomad configuration
RUN echo 'data_dir  = "/var/lib/nomad"\nserver {\n  enabled = true\n  bootstrap_expect = 1\n}' > /etc/nomad.d/nomad.hcl

# Start Nomad server
CMD ["nomad", "agent", "-config=/etc/nomad.d/nomad.hcl"]