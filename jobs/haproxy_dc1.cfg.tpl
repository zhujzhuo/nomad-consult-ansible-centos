global
    log 127.0.0.1 len 2048 local2
    ulimit-n 655360
    maxconn 40000


    stats socket /tmp/haproxy.sock mode 666
    stats timeout 30s

defaults
    log global
    mode tcp
    timeout client 28800s
    timeout connect 10s
    timeout server 28800s
    option tcplog
    option dontlognull
    option redispatch
    option clitcpka
    option srvtcpka
    option tcpka
    #option logasap  # 记录连接,无法统计tcp 流量
    retries 3


listen stats
    mode http
    bind :4000                            #找一个比较特殊的端口
    bind-process 1
    stats enable
    stats hide-version                    #隐藏haproxy版本号
    stats uri     /hpadmin?stats          #一会用于打开状态页的uri
    stats realm   Haproxy\ Statistics     #输入账户密码时的提示文字
    stats auth    admin:admin             #用户名:密码
    stats admin if TRUE                   #开启状态页的管理功能



listen 6032-readwrite
    balance leastconn
    bind :6032
    server 6032:10.32.204.19 10.32.204.19:6032  weight 100
