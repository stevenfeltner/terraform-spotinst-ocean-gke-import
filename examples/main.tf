provider "google" {
  # Configuration options
  project = var.project
}
#initialize the kubernetes provider with access to the specific cluster
provider "kubernetes" {
  host  = "https://${data.google_container_cluster.gke.endpoint}"
  token = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(data.google_container_cluster.gke.master_auth[0].cluster_ca_certificate)
}

### data resources ###
data "google_client_config" "default" {}

#Retrieve cluster info to get instance group URLS
data "google_container_cluster" "gke" {
  name     = var.cluster_name
  location = var.location
}


### Spot Ocean resource - Create the Ocean Cluster ###
module "ocean-gke-import" {
  source = "stevenfeltner/ocean-gke-import/spotinst"

  # Credentials.
  spotinst_token      = var.spot_token
  spotinst_account    = var.spot_account

  cluster_name        = var.cluster_name
  location            = var.location
}


### Deploy Ocean Controller Pod into Cluster ###
module "ocean-controller" {
  source = "spotinst/ocean-controller/spotinst"

  # Credentials.
  spotinst_token      = var.spot_token
  spotinst_account    = var.spot_account

  # Configuration.
  create_controller = true
  cluster_identifier  = spotinst_ocean_gke_import.ocean.cluster_controller_id
  disable_auto_update = false
}