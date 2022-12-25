provider "vsphere" {
  user           = var.vs_user
  password       = var.vs_pass
  vsphere_server = var.vs_server

  allow_unverified_ssl = true
}


data "vsphere_datacenter" "dc" {
  name = var.dc_name
}

data "vsphere_datastore" "datastore" {
  name = var.vm-datastore

  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = var.net_name
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = var.vm-template-name
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "pool" {
  name          = var.resource_pool
  datacenter_id = data.vsphere_datacenter.dc.id
}


# Create Control VMs

resource "vsphere_virtual_machine" "control" {
  count            = var.control-count
  name             = "${var.vm-prefix}-m${count.index + 1}-${var.resource_pool}"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = var.vm-cpu
  memory   = var.vm-ram
  guest_id = var.vm-guest-id


  cdrom {
    client_device = true
  }

  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label = "${var.vm-prefix}-${count.index + 1}-disk"
    size  = var.disk-size
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    # Install manual ip add

    # customize {
    #     linux_options {
    #     host_name = "${var.vm-prefix}-m${count.index + 1}"
    #     domain = var.vm-domain
    #     }

    #     network_interface {
    #     ipv4_address = "192.168.1.25${count.index + 1}"
    #     ipv4_netmask = 24
    #     }

    #     ipv4_gateway = "192.168.1.1"
    #     dns_server_list = [ "192.168.1.2" ]

    #  }
  }
}


# Create Worker VMs

resource "vsphere_virtual_machine" "worker" {
  count            = var.worker-count
  name             = "${var.vm-prefix}-w${count.index + 1}-${var.resource_pool}"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id


  num_cpus = var.vm-cpu
  memory   = var.vm-ram
  guest_id = var.vm-guest-id

  cdrom {
    client_device = true
  }


  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label = "${var.vm-prefix}-${count.index + 1}-disk"
    size  = var.disk-size
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    # Install manual ip add

    #     customize {
    #         timeout = 0

    #         linux_options {
    #         host_name = "${var.vm-prefix}-w${count.index + 1}"
    #         domain = var.vm-domain
    #         }

    #         network_interface {
    #         ipv4_address = "192.168.1.21${count.index + 1}"
    #         ipv4_netmask = 24
    #         }

    #         ipv4_gateway = "192.168.1.1"
    #         dns_server_list = [ "192.168.1.2" ]
    #     }
  }
}


# Create inventory file

resource "local_file" "AnsibleInventory" {
  content = templatefile("inventory.tmpl",
    {
      vm-names-control = [for k, p in vsphere_virtual_machine.control : p.name],
      control-ip       = [for k, p in vsphere_virtual_machine.control : p.default_ip_address],
      vm-names-worker  = [for k, p in vsphere_virtual_machine.worker : p.name],
      worker-ip        = [for k, p in vsphere_virtual_machine.worker : p.default_ip_address],
    }
  )
  filename = "../../../kubespray/inventory/k8s/inventory.ini"
}

# Install k8s cluster

resource "null_resource" "cluster" {
  provisioner "local-exec" {
    command = "ansible-playbook -i ../../../kubespray/inventory/k8s/inventory.ini  --user=ubuntu --become --become-user=root ../../../kubespray/cluster.yml"
  }

  depends_on = [
    local_file.AnsibleInventory
  ]
}

# Copy kube config file

resource "null_resource" "config" {
  provisioner "local-exec" {
    command = "cp ../../../kubespray/inventory/k8s/artifacts/admin.conf ~/.kube/config" # enter path to user kube config
  }

  depends_on = [
    null_resource.cluster
  ]
}

# Install jenkins with helm 

resource "null_resource" "jenkins" {
  provisioner "local-exec" {
    command = "../../../helm/jenkins/install.sh"
  }

  depends_on = [
    null_resource.config
  ]
}

output "control_ip_addresses" {
  value = vsphere_virtual_machine.control.*.default_ip_address
}

output "worker_ip_addresses" {
  value = vsphere_virtual_machine.worker.*.default_ip_address
}

