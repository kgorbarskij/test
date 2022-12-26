## Infrastructure configuration

- By default terraform initializes 4 virtual hosts based on ubuntut 20.04
  1 host is used for the control plane and 3 hosts for the data plane in kubernetes. If necessary, the number can be changed by configuring the control-count and worker-count variables.
  To access the vsphere hypervisor, you will need to specify a login and password at startup or define the vs_user and vs_pass variables. The resource_pool, vm-datastore, net_name variables need to be redefined depending on the VSphere setup.

- After initialization, an inventory file is generated according to the template and copied to [kubspray]() for further infrastructure configuration.

- After the infrastructure is initialized, Jenkins will be installed using [Helm]()
