#!/bin/bash


export ISTIO_VERSION='1.4.2'

cd ./0.0--setup-istio

kubectl apply -f ./ns.yaml

printf '\n== Applying: "%s" to kube-cluster ...\n' "istio-crds"
helm template $HOME/istio-$ISTIO_VERSION/install/kubernetes/helm/istio-init --name-template istio-init --namespace istio-system | kubectl apply -f -

printf '\n== Waiting for all istio CRDs to be created ...\n'
kubectl -n istio-system wait --for=condition=complete job --all

printf '\n== Applying: "%s" to kube-cluster ...\n' "istio-components"
helm template $HOME/istio-$ISTIO_VERSION/install/kubernetes/helm/istio --name-template istio --namespace istio-system | kubectl apply -f -

printf '\n== Applying: "%s" to kube-cluster ...\n' "istio-ingressgateway"
kubectl apply -f ./istio-ingressgateway/

printf '\n== Applying: "%s" to kube-cluster ...\n' "destination-rules"
kubectl apply -f ./disable-tls-for-nonistio-hosts.yaml

printf '\n== Enabling automatic sidecar injection for namespace: "%s" ...\n' "default"
kubectl label namespace default istio-injection=enabled --overwrite

