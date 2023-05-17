# -*- mode: ruby -*-
# vi: set ft=ruby :
consul_local_port = "8500"
kv_path = "nginx.conf"

#regions = ["US","ER","APAC","LATAM"]
regions = ["US"]

Vagrant.configure("2") do |config|

    config.vm.define "consul" do |consul|
        consul.vm.network "private_network" , ip: "192.168.33.5"
        consul.vm.provider "docker" do |docker|
            docker.image = "consul:latest"
            docker.name = "consul"
            docker.has_ssh = false
            docker.ports = [consul_local_port+":8500"]
            docker.remains_running = true
            docker.env = {
              'CONSUL_LOCAL_CONFIG' => '{"server":true,"bootstrap_expect":1,"client_addr":"0.0.0.0"}',
              'CONSUL_BIND_INTERFACE' => 'eth1'
            }
        end
        consul.trigger.after :up do |trigger|
            trigger.info = "Add key"
            trigger.run = {inline: "curl -X PUT -T nginx/nginx.conf http://localhost:"+consul_local_port+"/v1/kv/" + kv_path }
        end
    end

    config.vm.define "prometheus" do |prometheus|
        prometheus.vm.network "private_network" , ip: "192.168.33.6"
        prometheus.vm.provider "docker" do |docker|
          docker.image = "prom/prometheus:latest"
          docker.name = "prometheus"
          docker.ports = ['9090:9090']
          docker.volumes = ["./prometheus.yml:/etc/prometheus/prometheus.yml"]
          docker.remains_running = true
        end
    end

    # Grafana configuration
    config.vm.define "grafana" do |grafana|
        grafana.vm.network "private_network" , ip: "192.168.33.7"
        grafana.vm.provider "docker" do |docker|
          docker.image = "grafana/grafana:latest"
          docker.name = "grafana"
          docker.ports = ['3000:3000']
          docker.remains_running = true
        end
    end

    (1..regions.length() ).each do |idx|
        region_name = regions[idx-1].downcase
        config.vm.define "nginx-" + region_name do |node|
          node.vm.hostname = "nginx." + region_name
          node.vm.network "private_network", ip: "192.168.33.10%d" % idx
          node.vm.provider "docker" do |docker|
            docker.ports = ["808%d:80" % idx]
            docker.name = "nginx-" + region_name
            docker.build_dir = "nginx"
            docker.links = ["consul", "prometheus"]
            docker.env = {
              'CONSUL_LOCAL_CONFIG' => '{"server":false}',
              'CONSUL_BIND_INTERFACE' => 'eth1'
            }
          end
        end
    end

end
