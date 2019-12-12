#!/bin/bash

export ISTIO_VERSION='1.4.2'

cd ./0.0--setup-istio

printf '\n== Generating istio CRDs ...\n'
helm template $HOME/istio-$ISTIO_VERSION/install/kubernetes/helm/istio-init --name-template istio-init --namespace istio-system > istio-crds.yml

printf '\n== Generating istio configs ...\n'
helm template $HOME/istio-$ISTIO_VERSION/install/kubernetes/helm/istio --name-template istio --namespace istio-system > istio-install.yml

