# IaC

The repository contains a number of methods and templates used to fully initialize a virtual infrastructure from scratch based on VSphere and configure it, which will serve to deploy various kinds of micro-service applications using a combination of technologies terraform + packer + ansible + docker + kubernetes + jenkins

## Dependencies

- For initialization it is necessary to install [Terraform](https://developer.hashicorp.com/terraform/downloads) depending on the host operating system
- Auto setup requires [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- If fine-tuning is required, you will need [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-windows/)

## Description

The infrastructure is deployed based on VSphere ESXI 6.5+. [Terraform]() initializes deployment of virtual hosts from prepared Ubuntu20.04 templates configured with [Packer](). Next, the k8s cluster is deployed using [Kubespray](). Kubernetes cluster already contains the minimum required settings for using CI / CD based on Jenkins.
Using Load Balancer with [metalLB](https://metallb.org/) and workload scaling with [Horizontal Pod Autoscaling
](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/) Application source code is stored in the [apps]() folder. [Jenkins]() is configured to build applications using [Docker](https://www.
docker.com) files and storing the result in the registry. Application deployment happens by running a Docker image in a kubernetes cluster. Notification about the result of the assembly occurs using the telegram bot.

## Initialization

- To initialize the whole process (deploying the infrastructure, building and running applications), you must specify all the dependencies in the configuration files and apply the [terraform]() file.
