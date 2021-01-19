// https://registry.terraform.io/modules/terraform-google-modules/network/google/latest
// https://github.com/terraform-google-modules/terraform-google-network
module "gcp-network" {
  source = "terraform-google-modules/network/google"
  version = "3.0.0"
  project_id = var.project_id
  network_name = var.network_name
  //
  subnets = [
    {
      // Understanding IP address management in GKE
      // https://cloud.google.com/blog/products/containers-kubernetes/ip-address-management-in-gke
      subnet_name = var.subnetwork_name
      subnet_ip = var.subnetwork_ip_range
      subnet_region = var.region
    },
  ]
  secondary_ranges = {
    "${var.subnetwork_name}" = [
      {
        range_name = var.ip_range_pods_name
        ip_cidr_range = var.pods_network_ip_range
      },
      {
        range_name = var.ip_range_services_name
        ip_cidr_range = var.services_network_ip_range
      },
    ]
  }
}