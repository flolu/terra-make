# Make will use bash instead of sh
SHELL := /usr/bin/env bash
CC=clang # required by bazel

# GNU make man page
# http://www.gnu.org/software/make/manual/make.html

.PHONY: help
help:
	@echo 'Usage: '
	# auto-run 
	@echo '    auto-install:   		Automatically installs cluster & project in one command.'
	@echo '    auto-update:   		Updates entire project in an existing cluster.'

	# setup commands 
	@echo '    make setup:   		Installs all requirements and tools.'
	@echo '    make configure-cloud:	Configures and authenticates cloud provider.'

	# cluster commands
	@echo '    make create-cluster:  	Creates Kubernetes cluster.'
	@echo '    make update-cluster:  	Updates Kubernetes cluster.'
	@echo '    make destroy-cluster: 	Destroys Kubernetes cluster.'

	# container commands
	@echo '    make setup-deployment    	Prepares container deployment.'
#	@echo '    make deployment     		Deploys all services with bazel.'

.PHONY : auto-install
auto-all: setup configure-cloud create-cluster setup-deployment deployment

.PHONY : auto-update
auto-update: deployment

# "---------------------------------------------------------"
# Setup, configuration & installation
# "---------------------------------------------------------"
.PHONY: setup
setup:
	@source scripts/cloud/install-requirements.sh

.PHONY: configure-cloud
configure-cloud:
	@source scripts/cloud/configure-gcloud.sh

# "---------------------------------------------------------"
# Building & managing the cluster
# "---------------------------------------------------------"
.PHONY: create-cluster
create-cluster:
	@source scripts/cluster/make-cluster.sh

.PHONY: update-cluster
update-cluster:
	@source scripts/cluster/update-cluster.sh

.PHONY: destroy-cluster
destroy-cluster:
	@source scripts/cluster/destroy-cluster.sh

# "---------------------------------------------------------"
# Deploy containers to the cluster
# "---------------------------------------------------------"
.PHONY: setup-deployment
setup-deployment:
	# Make sure kubectl is correctly configured for deployments!
	@source scripts/containers/setup-deployment.sh

	# Build builder containers.
	@source scripts/containers/make-builders.sh

	# Build required containers with builders.
	@source scripts/containers/make-req-containers.sh

.PHONY: deployment
deployment:
	# Build service containers.
	@source scripts/containers/make-deployment.sh
