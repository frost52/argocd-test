#!/usr/bin/env bash

k3d cluster create dev-cluster --k3s-arg '--tls-san=192.168.0.235@server:0' --config dev-cluster-config.yaml
