# terra-make

Make & Bash scripts to fully automate GKE cluster creation, management, deployment with terraform, Bazel, and Bash. 

## Important: 
* All terraform configuration files must be present at the path {root}/terraform/main
* Google cloud only for now. Porting the scripts to other Cloud proividers largely means replacing the terraform configuration. 
* No bazel config provided. Bazel is well documented. Example of how to build containers with Bazel can be [found here](https://github.com/marvin-hansen/bazel-docker) 
* No native Windows support. Only Linux or WSL for now. 
* Mac not tested. 

## Requirements
* Ubuntu 20.04.1 LTS (Focal Fossa) environment i.e. Docker / WSL etc.  

## Getting started:

1. git clone https://github.com/marvin-hansen/terra-make.git
2. cd terra-make
3. make 

Note, some deployment scripts may not work due to missing bazel targets. Feel free to adopt to build your own project. 
The setup & cluster scripts should work fine b/c during setup all requirements used in these scripts get installed if not already present. 

## Usage:

Auto-mode
* make auto-install:   		-- Automatically installs cluster & project in one command.
* auto-update:   		      -- Updates entire project in existing cluster.

Setup: 
*    make setup   		    -- Installs all requirements and tools.
*    make configure-cloud -- Configures and authenticates cloud provider.

Cluster commands
* make create-cluster     -- Creates Kubernetes cluster.
* make update-cluster     -- Updates Kubernetes cluster.
* make destroy-cluster 	  -- Destroys Kubernetes cluster.

Deployment:

* make configure-deployment   -- Prepares container deployment.
* make deployment     		-- Deploys all services with bazel & K8s rules 
