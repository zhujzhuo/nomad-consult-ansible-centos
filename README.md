# Deploy Nomad & Consult via ansible, on Centos nodes #

## What you will get? ###

* Setup a 5 nodes (3 server, 2 clients) hashicorp nomad container orchestrator
* Run all on your prefered cloud provider via ansible


## Architecture of the stack

![nomad.PNG](https://github.com/gregbkr/nomad-consult-ansible-centos/raw/master/nomad.PNG)

- **Master/client nomad host**: master will take care of electing cluster leader, planning and rescheduling nomad jobs. While client will report node status to the master and look for jobs to run, and then run container
- **Consul**: service discovery. Nomad will record nodes, services in this database. Consul is replicated and  present on all nodes so nomad agents always have access to this data locally
- **dnsmasq**: a kind of proxy for dns resolution, route *.consul query to consul, and other query to localhost then internet
- **Ansible**: recipe will provide easy deployment of the solution

## Prerequisit

* Ansible
* A cloud infra providing centos hosts

## Deploy nomad cluster

Clone this repo

    git clone https://github.com/zhujzhuo/nomad-consult-ansible-centos

Please deploy 3 standard Centos hosts (nomad-server1,nomad-server2,nomad-server3, nomad-client1, nomad-client2) on your prefered cloud provider.

Edit ansible inventory with your ips and ssh access key:

    vim inventory

**Add vagrant env

https://www.vagrantup.com/docs/installation/

https://www.vagrantup.com/docs/cli/

    vagrant box add centos/7

**Deploy consul, docker, dnsmasq & nomad**

Run few times until you got no more errors)

    ansible-playbook -i inventory  playbook.yml


    nomad run redis.nomad
    nomad run flask.nomad
    nomad run nginx.nomad

**Test services**

Redis

    echo 'PING' | nc global-redis-check.service.consul 6379

flask
  
    curl global-flask-check.service.consul:5000
 
Nginx

    curl global-nginx-check.service.consul
 

## Troubleshooting

check nomad status

    nomad status
    nomad server-members
    nomad status redis
    nomad alloc-status <alloc-id>

Delete nomad job

    nomad stop redis
