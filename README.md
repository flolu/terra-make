# terra-make

Make & Bash scripts to fully automate GKE cluster creation, management, deployment with terraform, Bazel, and Bash. 

Important: All terraform configuration files must be present at the path {root}/terraform/main

See provided 

## Usage:

Setup: 
*    make setup:   		Installs all requirements and tools.
*    make configure-cloud:	Configures and authenticates cloud provider.

cluster commands
* make create-cluster:  	Creates Kubernetes cluster.'
* make update-cluster:  	Updates Kubernetes cluster.'
* make destroy-cluster: 	Destroys Kubernetes cluster.'

Deployment:

* make setup-deployment    Prepares container deployment.
* make deployment     		Deploys all services with bazel.
