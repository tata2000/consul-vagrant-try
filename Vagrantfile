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
end
