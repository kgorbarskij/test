# Install Jenkins with Helm

- The Jenkins installation is initialized in kubernetes using [terraform]() after configuring all the necessary infrastructure in the form of virtual hosts and a kubernetes cluster.

- By default, Jenkins stores all its data on the selected node using PersistentVolume
- Has access through port 80 configured as a service. To access by DNS name, you need to define a variable in jenkins-value.yaml
  jenkinsUrl
- There are default plugins such as:
  - kubernetes:3734.v562b_b_a_627ea_c
  - workflow-aggregator:590.v6a_d052e5a_a_b_5
  - git:4.13.0
  - configuration-as-code:1569.vb_72405b_80249
  - SSH Agent Plugin
  - Job DSL
  - Job Import

All settings can be changed/added/removed by redefining variables in the jenkins-values.yaml and jenkins.yaml files prior to [terraform]() initialization
