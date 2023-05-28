# -*- mode: ruby -*-
# vi: set ft=ruby :
consul_local_port = "8500"
key_name = "nginx.conf"
local_nginx_file = ".nginx.conf"

regions = ["us","er","apac","latam"]

Vagrant.configure("2") do |config|

    config.vm.define "consul" do |consul|
        consul.vm.network "private_network" , ip: "192.168.33.5"
        consul.vm.provider "docker" do |docker|
            docker.image = "consul:latest"
            docker.name = "consul"
            docker.has_ssh = false
            docker.ports = [consul_local_port+":8500"]
            docker.remains_running = false
            docker.env = {
              'CONSUL_LOCAL_CONFIG' => '{"server":true,"bootstrap_expect":1,"client_addr":"0.0.0.0"}',
              'CONSUL_BIND_INTERFACE' => 'eth1'
            }
            docker.volumes = []
        end

        #First init of nginx template
        (1..regions.length() ).each do |idx|
            kv_path = "" + regions[idx-1].downcase + "/" + key_name
            consul.trigger.after :up do |trigger|
                trigger.info = "Add key for " + kv_path
                trigger.run = {inline: "bash -c 'cat nginx.conf.tmpl | envsubst > #{local_nginx_file};
                curl -X PUT -T #{local_nginx_file}  http://localhost:"+consul_local_port+"/v1/kv/" + kv_path + "'" }
            end
        end

        regions.each do |region|
            consul.trigger.after :up do |trigger|
               trigger.info = "Start agent for " + region
               trigger.run = {inline:  "bash -c '(nomad agent -config nomad-#{region}.hcl &> #{region}.log) &'" }
            end
        end

        consul.trigger.after :up do |trigger|
            trigger.info = "Sleeping before job submission"
            trigger.run =  {inline: "sleep 10"}
        end

        consul.trigger.after :up do |trigger|
            trigger.info = "Apply nginx nomad job"
            trigger.run = {inline: "nomad run nginx-consul.nomad"}
        end

        consul.trigger.after :up do |trigger|
            trigger.info = "Sleeping before version update"
            trigger.run =  {inline: "sleep 60"}
        end

        (2 .. 100 ).each do | version_number |
            regions.each do |region|
                consul.trigger.after :up do |trigger|
                    kv_path = "" + region + "/" + key_name
                    trigger.info = "Update key for " + kv_path
                    trigger.run = {inline: "bash -c 'export version_number="+version_number.to_s +
                        "; cat nginx.conf.tmpl | envsubst > #{local_nginx_file};
                        curl -X PUT -T .nginx.conf  http://localhost:"+consul_local_port+"/v1/kv/" + kv_path + ";
                        sleep 10'" }
                end
            end
        end


    end
end
