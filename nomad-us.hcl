datacenter = "us"
data_dir = "/Users/tata/tmp/terasky/final/local/nomad/data"

client {
  enabled = true
  servers = ["localhost:4647"]
  alloc_dir =  "/Users/tata/tmp/terasky/final/local/nomad/alloc"
}

advertise {
  http = "127.0.0.1:4646"
  rpc  = "127.0.0.1:4647"
  serf = "127.0.0.1:4648"
}

bind_addr = "127.0.0.1" # the default

server {
  enabled          = true
  bootstrap_expect = 1
}

client {
  enabled       = true
}

consul {
  address = "127.0.0.1:8500"
}