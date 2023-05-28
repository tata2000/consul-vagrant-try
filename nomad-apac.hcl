datacenter = "apac"
data_dir = "/tmp/nomad-apac/data"

client {
  enabled = true
  servers = ["localhost:4647"]
  alloc_dir =  "/tmp/nomad-apac/alloc"
}

ports {
  http = 6646
  rpc  = 6647
  serf = 6648
}