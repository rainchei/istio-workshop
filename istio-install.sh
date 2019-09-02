#!/bin/bash


cd ./0.0--setup-istio

kubectl apply -f ./ns.yaml

printf '\n== Applying: "%s" to kube-cluster ...\n' "istio-crds"
kubectl apply -f ./istio-crds/

printf '\n== Applying: "%s" to kube-cluster ...\n' "istio-components"
while ! [ $(kubectl get crds | grep 'istio.io\|certmanager.k8s.io' | wc -l) = 28 ]
do
  printf '  ... "%s" crds still not ready, will check again in 10s\n' "istio"
  sleep 10
done
kubectl apply -f ./istio122-demo-auth.yaml

printf '\n== Applying: "%s" to kube-cluster ...\n' "istio-ingressgateway"
kubectl apply -f ./istio-ingressgateway/

printf '\n== Applying: "%s" to kube-cluster ...\n' "destination-rules"
kubectl apply -f ./disable-tls-for-nonistio-hosts.yaml

printf '\n== Enabling automatic sidecar injection for namespace: "%s" ...\n' "default"
kubectl label namespace default istio-injection=enabled --overwrite

