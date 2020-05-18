job "loadbalancer_dc1" {
    datacenters = ["dc1"]
    type = "service"
    priority = 30

    update {
      stagger = "20s"
      max_parallel = 1
    }

    constraint {
      distinct_hosts = true
    }
    constraint {
      attribute = "${node.class}"
      value     = "prod"
    }

    group "lb_dc1" {
      count = 1
      restart {
          mode = "fail"
          attempts = 10
          delay    = "100s"
      }

      task "haproxy" {
        driver = "raw_exec"
        config {
          command = "/usr/local/sbin/haproxy"
          args = [
            "-db",
            "-W" ,
            "-f","local/conf/haproxy.cfg"
          ]
        }

        template {
          source = "/vagrant/jobs/haproxy_dc1.cfg.tpl"
          destination = "local/conf/haproxy.cfg"
          change_mode = "signal"
          change_signal = "SIGUSR2"
        }

        service {
          tags  = ["vtgate_lb"]
          name  = "haproxy"
          port  = "haproxy"

          check {
            name     = "alive"
            type     = "tcp"
            port     = "haproxy"
            interval = "10s"
            timeout  = "2s"
          }
        }

        resources {
          cpu = 50
          memory = 200
          network {
            mbits = 100
            port "haproxy" {
                static = "2000"
            }
          }
        }
      }
  }
}
