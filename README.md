# terra-make

Make & Bash scripts to fully automate GKE cluster creation, management, deployment with terraform, Bazel, and Bash. 

Important: 
* All terraform configuration files must be present at the path {root}/terraform/main
* Google cloud only for now. Porting the scripts to other Cloud proividers largely means replacing the terraform configuration. 
* No bazel config provided. Bazel is well documented. Example of how to build containers with Bazel can be [found here](https://github.com/marvin-hansen/bazel-docker) 

## Usage:

Setup: 
*    make setup   		-- Installs all requirements and tools.
*    make configure-cloud -- Configures and authenticates cloud provider.

cluster commands
* make create-cluster   -- Creates Kubernetes cluster.
* make update-cluster   -- Updates Kubernetes cluster.
* make destroy-cluster 	-- Destroys Kubernetes cluster.

Deployment:

* make setup-deployment    -- Prepares container deployment.
* make deployment     		-- Deploys all services with bazel & K8s rules 
