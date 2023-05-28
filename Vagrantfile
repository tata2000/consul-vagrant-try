# -*- mode: ruby -*-
# vi: set ft=ruby :
consul_local_port = "8500"
key_name = "nginx.conf"

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
            docker.volumes = []
        end

        (1..regions.length() ).each do |idx|
            kv_path = "" + regions[idx-1]+ "/" + key_name
            consul.trigger.after :up do |trigger|
                trigger.info = "Add key for us"
                trigger.run = {inline: "curl -X PUT -T nginx.conf http://localhost:"+consul_local_port+"/v1/kv/" + kv_path }
            end
        end

        consul.trigger.after :up do |trigger|
         `(nomad agent -config nomad-us.hcl &> us.log) &`
             trigger.info = "Start nomad as server"
#             trigger.run = {inline: "`(nomad agent -config nomad-us.hcl &> us.log) &`"}
        end

        consul.trigger.after :up do |trigger|
            trigger.info = "Start nomad client"
            trigger.run = {inline: "nomad agent -config nomad-er.hcl > eu.log &"}
        end
    end

#     config.vm.define "nomad" do |nomad|
#         nomad.vm.network "private_network" , ip: "192.168.33.4"
#         nomad.vm.provider "docker" do |docker|
#             docker.build_dir = "nomad"
#             docker.name = "nomad"
#             docker.has_ssh = false
#             docker.remains_running = true
#             docker.env = {
#               'NOMAD_LOCAL_CONFIG' => '{"server":true,"bootstrap_expect":1,"client_addr":"0.0.0.0"}',
#               'NOMAD_BIND_INTERFACE' => 'eth0'
#             }
#         end
#         nomad.vm.network "forwarded_port", guest: 4646, host: 4646
#         nomad.vm.network "forwarded_port", guest: 4647, host: 4647
#         nomad.trigger.after :up do |trigger|
#             trigger.info = "Nomad Server is up and running!"
#         end
#     end

#     config.vm.define "prometheus" do |prometheus|
#         prometheus.vm.network "private_network" , ip: "192.168.33.6"
#         prometheus.vm.provider "docker" do |docker|
#           docker.image = "prom/prometheus:latest"
#           docker.name = "prometheus"
#           docker.ports = ['9090:9090']
#           #docker.volumes = ["./prometheus.yml:/etc/prometheus/prometheus.yml"]
#           docker.remains_running = true
#         end
#     end

#     # Grafana configuration
#     config.vm.define "grafana" do |grafana|
#         grafana.vm.network "private_network" , ip: "192.168.33.7"
#         grafana.vm.provider "docker" do |docker|
#           docker.image = "grafana/grafana:latest"
#           docker.name = "grafana"
#           docker.ports = ['3000:3000']
#           docker.remains_running = true
#         end
#     end
#
#     (1..regions.length() ).each do |idx|
#         region_name = regions[idx-1].downcase
#         config.vm.define "nomad-client-"+ region_name do |node|
#         node.vm.hostname = "nginx." + region_name
#           node.vm.network "private_network", ip: "192.168.33.20%d" % idx
#           node.vm.provider "docker" do |docker|
#             docker.ports = ["%d4646:4646" % idx]
#             docker.name = "nomad-client-" + region_name
#             docker.build_dir = "nginx"
#             docker.volumes = [
#                 "/var/run/docker.sock:/var/run/docker.sock:rw",
#                 "#{File.expand_path("../tmp/", __FILE__)}:/nomad",
#                 "#{File.expand_path("../nginx/nomad", __FILE__)}:/etc/nomad.d/",
#                 "#{File.expand_path("../nginx/consul.d", __FILE__)}:/etc/consul.d/",
#                 "#{File.expand_path("../nginx/consul-template", __FILE__)}:/etc/consul-template/",
#                 "#{File.expand_path("../nginx/entrypoint.sh", __FILE__)}:/entrypoint.sh"
#             ]
#             docker.env = {
#               'CONSUL_LOCAL_CONFIG' => '{"server":false,"client_addr":"0.0.0.0"}',
#               'CONSUL_BIND_INTERFACE' => 'eth1'
#             }
#             docker.remains_running = false
#           end
#         end
#         config.vm.define "nginx-" + region_name do |node|
#           node.vm.hostname = "nginx." + region_name
#           node.vm.network "private_network", ip: "192.168.33.10%d" % idx
#           node.vm.provider "docker" do |docker|
#             docker.ports = ["808%d:80" % idx]
#             docker.name = "nginx-" + region_name
#             docker.build_dir = "nginx"
#             docker.volumes = [
#                 "#{File.expand_path("../nginx/nomad", __FILE__)}:/etc/nomad.d/",
#                 "#{File.expand_path("../nginx/consul.d", __FILE__)}:/etc/consul.d/",
#                 "#{File.expand_path("../nginx/consul-template", __FILE__)}:/etc/consul-template/",
#                 "#{File.expand_path("../nginx/entrypoint.sh", __FILE__)}:/entrypoint.sh"
#             ]
#             docker.env = {
#               'CONSUL_LOCAL_CONFIG' => '{"server":false,"client_addr":"0.0.0.0"}',
#               'CONSUL_BIND_INTERFACE' => 'eth1'
#             }
#             docker.remains_running = false
#           end
#         end
#     end
end
