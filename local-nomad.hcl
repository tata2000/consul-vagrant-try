datacenter = "dc1"
data_dir = "/Users/tata/tmp/terasky/final/local/nomad/data"
client {
  enabled = true
  servers = ["localhost:4647"]
  alloc_dir =  "/Users/tata/tmp/terasky/final/local/nomad/alloc"
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