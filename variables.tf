### Variables ###
variable "cluster_name" {
  type        = string
  description = "Name of GKE Cluster"
}
variable "spot_token" {
  type        = string
  description = "Spot Token"
}
variable "spot_account" {
  type        = string
  description = "Spot Account ID"
}
variable "location" {
  type        = string
  description = "Location of cluster. ie us-west2a"
}
#################