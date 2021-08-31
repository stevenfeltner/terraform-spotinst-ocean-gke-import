terraform {
  required_providers {
    spotinst = {
      source = "spotinst/spotinst"
    }
  }
}

### Provider ###
provider "spotinst" {
  token   = var.spot_token
  account = var.spot_account
}

### Spot Ocean resource - Create the Ocean Cluster ###
resource "spotinst_ocean_gke_import" "ocean" {
  cluster_name        = var.cluster_name
  location            = var.location
  desired_capacity    = 1
  min_size            = 0
  max_size            = 1000

  lifecycle {
    ignore_changes = [
      desired_capacity
    ]
  }

}





