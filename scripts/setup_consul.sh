#!/usr/bin/env bash

cd /opt/hashicorp
pip install docker-compose
docker-compose up -d --build
docker-compose exec -T consul bash -c "consul validate /consul/consul.d/server/config.json"

export MASTER_TOKEN=9beb4f8e-7220-41d2-946c-b8a8e3574692
curl --header "X-Consul-Token: $MASTER_TOKEN" --request PUT --data "ofir_test" http://127.0.0.1:8500/v1/kv/test
curl --header "X-Consul-Token: $MASTER_TOKEN" --request GET http://127.0.0.1:8500/v1/kv/test