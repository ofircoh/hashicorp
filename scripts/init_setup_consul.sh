#!/usr/bin/bash

#cd into consul directory
cd /opt/hashicorp

# install docker-compose
pip3.6 install docker-compose

# remove any previous data
rm -rf /opt/hashicorp/consul/data/*

#build condul image and run the container
docker-compose up -d --build

#validate consul configuration file
docker-compose exec -T consul bash -c "consul validate /consul/consul.d/server/"

#test kv input to consul
export MASTER_TOKEN=9beb4f8e-7220-41d2-946c-b8a8e3574692
curl --header "X-Consul-Token: $MASTER_TOKEN" --request PUT --data "ofir_test" http://127.0.0.1:8500/v1/kv/test
curl --header "X-Consul-Token: $MASTER_TOKEN" --request GET http://127.0.0.1:8500/v1/kv/test