job "nginx" {
  datacenters = ["us","eu"]
  type = "service"

  group "nginx" {
    count = 35

    update {
      canary       = 0
      max_parallel = 30
    }
    network {
      mode = "host"

      port "http" {
        to = 80
      }
    }

    task "nginx-1" {
      driver = "docker"
      config {
        image   = "nginx"
        ports   = ["http"]
        volumes = [
          "nginx.conf:/etc/nginx/nginx.conf"
        ]
      }
      template {
        data = <<EOH
{{ $dc := env "NOMAD_DC" -}}
{{ printf "%s/nginx.conf" $dc | key}}
EOH
        destination = "nginx.conf"
#        change_mode = "noop"
        change_mode   = "signal"
        change_signal = "SIGHUP"
      }
      resources {
        cpu    = 100 # 100 MHz
        memory = 128 # 128 MB
      }
      service {
        name = "nginx"
        tags = ["nginx"]
        port = "http"
      }
    }
  }
}
