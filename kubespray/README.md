# Deploy Kubernetes Cluster

## Start

Configured by default for deployment by applying the inventory file in the kubespray/inventory/k8s/inventory.ini folder, which is generated from the [terraform]() template at the virtual hosts initialization stage

If necessary, you can override the variables in the kubespray/inventory/k8s/all folder and
kubespray/inventory/k8s/k8s_cluster

## Requirements

- **Minimum required version of Kubernetes is v1.23**
- **Ansible v2.11+, Jinja 2.11+ and python-netaddr is installed on the machine that will run Ansible commands**
- The target servers must have **access to the Internet** in order to pull docker images. Otherwise, additional configuration is required
- The target servers are configured to allow **IPv4 forwarding**.
- If using IPv6 for pods and services, the target servers are configured to allow **IPv6 forwarding**.
- The **firewalls are not managed**, you'll need to implement your own rules the way you used to.
  in order to avoid any issue during deployment you should disable your firewall.
- If kubespray is ran from non-root user account, correct privilege escalation method
  should be configured in the target servers. Then the `ansible_become` flag
  or command parameters `--become or -b` should be specified.

Hardware:
These limits are safe guarded by Kubespray. Actual requirements for your workload can differ. For a sizing guide go to the [Building Large Clusters](https://kubernetes.io/docs/setup/cluster-large/#size-of-master-and-master-components) guide.

- Master
  - Memory: 1500 MB
- Node
  - Memory: 1024 MB

## Ingress Plugins

- [nginx](https://kubernetes.github.io/ingress-nginx): the NGINX Ingress Controller.

- [metallb](docs/metallb.md): the MetalLB bare-metal service LoadBalancer provider.
