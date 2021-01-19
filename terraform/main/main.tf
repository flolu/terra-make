// https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest/submodules/private-cluster
// https://github.com/terraform-google-modules/terraform-google-kubernetes-engine/tree/master/modules/private-cluster
module "gke" {
  source = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  version = "12.3.0"
  project_id = var.project_id
  name = var.cluster_name
  //
  regional = true
  region = var.region
  zones = var.multi-zones
  release_channel = var.release_channel
  //
  http_load_balancing = true
  horizontal_pod_autoscaling = true
  enable_vertical_pod_autoscaling = true
  cluster_autoscaling = var.cluster_autoscaling_OFF
  //
  network_policy = true
  enable_private_endpoint = false
  enable_private_nodes = true
  //
  network = module.gcp-network.network_name
  subnetwork = module.gcp-network.subnets_names[0]
  ip_range_pods = var.ip_range_pods_name
  ip_range_services = var.ip_range_services_name
  create_service_account = true
  //
  node_pools = [
    {
      name = var.default_pool_name
      machine_type = var.node_pool_machine_type_default
      initial_node_count = var.node_pool_init_nodes_default
      min_count = var.node_pool_min_nodes_default
      max_count = var.node_pool_max_nodes_default
      //
      local_ssd_count = var.node_pool_local_SSD_count_default
      disk_size_gb = var.node_pool_disk_size_default
      disk_type = var.node_pool_disk_type_default
      image_type = var.node_pool_image_type_default
      auto_repair = true
      auto_upgrade = true
      preemptible = false
    },
  ]

  node_pools_oauth_scopes = {
    all = []
    default-node-pool = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  node_pools_labels = {
    all = {}
    default-node-pool = {
      default-node-pool = true
    }
  }

  node_pools_metadata = {
    all = {}
    default-node-pool = {
      node-pool-metadata-custom-value = var.default_pool_name
    }
  }

  node_pools_tags = {
    all = []
    default-node-pool = [
      "default-node-pool",]
  }

}