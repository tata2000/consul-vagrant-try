# -*- mode: ruby -*-
# vi: set ft=ruby :
consul_local_port = "8500"
kv_path = "nginx.conf"

#regions = ["US","ER","APAC","LATAM"]
regions = ["US"]

Vagrant.configure("2") do |config|

    config.vm.provider "docker" do |d|
    d.image = "consul:latest"
    d.name = "consul"
    d.has_ssh = false
    d.ports = [consul_local_port+":8500"]
    d.remains_running = true
    d.env = {
      'CONSUL_LOCAL_CONFIG' => '{"server":true,"bootstrap_expect":1,"client_addr":"0.0.0.0"}',
      'CONSUL_BIND_INTERFACE' => 'eth0'
    }
    end
 config.vm.provision :host_shell do |host_shell|
    host_shell.inline = 'touch /tmp/hostshell-works && echo hello from the host && hostname 1>&2'
  end
#   config.vm.provision "shell" do |s|
#     s.inline = "echo hello"
#   end
#TODO change it to run only once
#     config.vm.provision :host_shell do |host_shell|
#         host_shell.inline = "curl -X PUT -T nginx.conf http://localhost:"+consul_local_port+"/v1/kv/" + kv_path
#     end
#     config.trigger.after :up,:provision do |trigger|
#       trigger.info =
#       trigger.run = {inline: "curl -X PUT -T nginx.conf http://localhost:"+consul_local_port+"/v1/kv/" + kv_path
#       }
#     end


#     (1..regions.length() ).each do |idx|
#         region_name = regions[idx-1].downcase
#         config.vm.define "nginx-" + region_name do |node|
#           node.vm.hostname = "nginx." + region_name
#           node.vm.network "private_network", ip: "192.168.33.10%d" % idx
#           node.vm.provider "docker" do |docker|
#             docker.ports = ["808%d:80" % idx]
#             docker.name = "nginx-" + region_name
#             docker.image = "ng2"
#           end
#           end
#     end
end

