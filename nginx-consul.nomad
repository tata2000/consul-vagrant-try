job "nginx" {
  datacenters = ["us","er","apac","latam"]
  type = "service"

  group "nginx" {
    count = 20

    spread {
      attribute = "${node.datacenter}"
      weight    = 100
    }

    update {
      canary       = 0
      max_parallel = 20
    }
    network {
      mode = "host"

      port "http" {
        to = 80
      }
    }

    task "nginx" {
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
        change_mode   = "signal"
        change_signal = "SIGHUP"
      }
      service {
        name = "nginx"
        tags = ["nginx"]
        port = "http"
      }
    }
  }
}
