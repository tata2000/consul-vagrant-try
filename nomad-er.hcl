datacenter = "er"
data_dir = "/tmp/nomad-er/data"

client {
  enabled = true
  servers = ["localhost:4647"]
  alloc_dir =  "/tmp/nomad-er/alloc"
}

advertise {
  http = "127.0.0.1:5646"
  rpc  = "127.0.0.1:5647"
  serf = "127.0.0.1:5648"
}
