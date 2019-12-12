#!/bin/bash


cd ./0.0--setup-istio

kubectl apply -f ./ns.yaml

printf '\n== Applying: "%s" to kube-cluster ...\n' "istio-crds"
kubectl apply -f ./istio-crds/

printf '\n== Applying: "%s" to kube-cluster ...\n' "istio-components"
kubectl apply -f ./istio-install.yml

printf '\n== Applying: "%s" to kube-cluster ...\n' "istio-ingressgateway"
kubectl apply -f ./istio-ingressgateway/

printf '\n== Applying: "%s" to kube-cluster ...\n' "destination-rules"
kubectl apply -f ./disable-tls-for-nonistio-hosts.yaml

printf '\n== Enabling automatic sidecar injection for namespace: "%s" ...\n' "default"
kubectl label namespace default istio-injection=enabled --overwrite

