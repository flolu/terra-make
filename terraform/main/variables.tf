variable "project_id" {
  description = "The project ID to host the cluster in"
  type = string
  # Value pulled from terraform.tfvars
}

variable "region" {
  description = "The region to host the cluster in"
  type = string
  # Value pulled from terraform.tfvars
}

variable "zone" {
  description = "The primary zone to host the cluster"
  type = string
  # Value pulled from terraform.tfvars
}

variable "multi-zones" {
  description = "The zone to host the cluster if it is a zonal cluster"
  type = list(string)
# Value pulled from terraform.tfvars
}

// cluster values
variable "cluster_name" {
  description = "The name of the cluster"
  type = string
  default = "quantum-main"
}

variable "cluster_autoscaling_OFF" {
  description = "Disables Autoscaling of the cluster"
  default = {
    "enabled": false,
    "min_cpu_cores": 0,
    "max_cpu_cores": 0,
    "min_memory_gb": 0
    "max_memory_gb": 0,
  }
}

variable "cluster_autoscaling_default" {
  description = "Enables Autoscaling of the cluster up to 10X the initial capacity"
  default = {
    "enabled": true,
    "min_cpu_cores": 6,
    "max_cpu_cores": 60,
    "min_memory_gb": 24
    "max_memory_gb": 240,
  }
}

variable "release_channel" {
  description = "The default release channel from which to pull updates.Accepted values are UNSPECIFIED, RAPID, REGULAR and STABLE"
  type = string
  default = "REGULAR"
}

// Understanding IP address management in GKE
// https://cloud.google.com/blog/products/containers-kubernetes/ip-address-management-in-gke
variable "network_name" {
  description = "The VPC network to host the cluster in"
  type = string
  default = "gke-main-network"
}

variable "subnetwork_name" {
  description = "The subnetwork to host the cluster in"
  type = string
  default = "gke-main-subnetwork"
}

variable "subnetwork_ip_range" {
  description = "The ip address of the cluster subnetwork"
  type = string
  default = "10.1.0.0/16"
}

variable "master_auth_subnetwork_name" {
  description = "The master auth  subnetwork name "
  type = string
  default = "gke-main-master_auth_subnetwork"
}

variable "ip_range_pods_name" {
  description = "The name of the secondary ip range to use for pods"
  type = string
  default = "ip-range-pods"
}

variable "pods_network_ip_range" {
  description = "The secondary ip range to use for pods"
  type = string
  default = "10.4.0.0/16"
}

variable "ip_range_services_name" {
  description = "The name of hte secondary ip range to use for services"
  type = string
  default = "ip-range-scv"
}

variable "services_network_ip_range" {
  description = "The secondary ip range to use for services"
  type = string
  default = "10.8.0.0/16"
}

variable "master_ipv4_cidr_block" {
  description = "The master ipv4 CIDR address block"
  type = string
  default = "10.0.0.0/28"
}

// pools
variable "default_pool_name" {
  description = "Name of the first node pool"
  type = string
  default = "default-main-pool"
}

variable "node_pool_min_nodes_default" {
  description = "Default min number of nodes in a pool."
  type = number
  default = 1
}

variable "node_pool_max_nodes_default" {
  description = "Default max number of nodes in a pool."
  type = number
  default = 7
}

variable "node_pool_init_nodes_default" {
  description = "Initial number of nodes in a pool."
  type = number
  default = 3
}

// nodes
variable "node_pool_machine_type_default" {
  description = "Default machine type of each node"
  type = string
  default = "n2d-standard-2"
}

variable "node_pool_image_type_default" {
  description = "Default OS image type of each node"
  type = string
  default = "COS"
}

variable "node_pool_disk_type_default" {
  description = "Default hard disk type of each node"
  type = string
  default = "pd-standard"
}

variable "node_pool_local_SSD_count_default" {
  description = "Default number of local SSD's of each node"
  type = number
  default = 0
}

variable "node_pool_disk_size_default" {
  description = "Default disk size in GB of each node"
  type = number
  default = 100
}
