job "example" {
  datacenters = ["dc1"]

  group "example" {
    task "server" {
      driver = "docker"

      config {
        image = "nginx:latest"
        port_map {
          http = 80
        }
      }

      template {
        data = <<EOH
{{ key "nginx.conf" }}
        EOH
        destination   = "/etc/nginx/nginx.conf"
        change_mode   = "restart"
      }

      resources {
        cpu    = 500
        memory = 256
        network {
          mbits = 10
          port "http" {}
        }
      }

      service {
        name = "nginx"
        port = "http"

        check {
          name     = "alive"
          type     = "tcp"
          interval = "10s"
          timeout  = "2s"
        }
      }
    }
  }
}
