#!/bin/bash

kubectl apply -f jenkins.yaml
kubectl apply -f jenkins-sa.yaml
helm install jenkins -n jenkins -f jenkins-values.yaml jenkinsci/jenkins
