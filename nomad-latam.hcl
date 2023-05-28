datacenter = "latam"
data_dir = "/tmp/nomad-latam/data"

client {
  enabled = true
  servers = ["localhost:4647"]
  alloc_dir =  "/tmp/nomad-latam/alloc"
}

ports {
  http = 7646
  rpc  = 7647
  serf = 7648
}