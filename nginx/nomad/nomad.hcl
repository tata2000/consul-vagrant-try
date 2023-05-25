datacenter = "dc1"
data_dir = "/nomad/data"

client {
  enabled = true
  servers = ["<nomad_server_address>:4647"]
}

advertise {
  http = "<host_ip>:4646"
  rpc  = "<host_ip>:4647"
  serf = "<host_ip>:4648"
}