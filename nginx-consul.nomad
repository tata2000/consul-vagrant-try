job "nginx" {
#  multiregion {
#
#    strategy {
#      max_parallel = 1
#      on_failure   = "fail_all"
#    }
#
#    region "us" {
#      count       = 1
#      datacenters = ["dc1"]
#    }
#
##    region "eu" {
##      count       = 1
##      datacenters = ["dc1"]
##    }
#  }
  datacenters = ["dc1"]
  type = "service"

  group "nginx" {
    count = 1

    update {
      canary       = 0
      max_parallel = 1
    }
    network {
      mode = "host"

      port "http" {
        to = 80
      }
    }

    task "nginx-1" {
      driver = "docker"
      datacenter = "dc1"
      config {
        image   = "nginx"
        ports   = ["http"]
        volumes = [
          "nginx.conf:/etc/nginx/nginx.conf"
        ]
      }
      template {
        data = "{{ key \"nginx.conf\" }}"
        destination = "nginx.conf"
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

#        check {
#          type     = "http"
#          path     = "/"
#          interval = "1s"
#          timeout  = "2s"
#        }
      }
    }
  }
}
