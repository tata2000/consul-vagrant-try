datacenter = "dc1"
data_dir = "/nomad/data"
client {
  enabled = true
  servers = ["nomad:4647"]
  alloc_dir =  "/nomad/data"
}
#
#advertise {
#  http = "<host_ip>:4646"
#  rpc  = "<host_ip>:4647"
#  serf = "<host_ip>:4648"
#}

plugin "raw_exec" {
  config {
    enabled = true
  }
}