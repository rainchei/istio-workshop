#!/bin/bash


cd ./5.0--logging-with-fluentd

kubectl apply -f ./ns.yaml

printf '\n== Applying: "%s" to kube-cluster ...\n' "elk-stack"
kubectl apply -f ./elk-stack/

