/*
* ------------------------------------------------------------------------------
* Variables
* ------------------------------------------------------------------------------
*/

variable "name" {
  description = "The name of your quoin."
}

variable "region" {
  description = "Region where resources will be created."
}

variable "cidr" {
  description = "A CIDR block for the network."
}

/*
* ------------------------------------------------------------------------------
* Providers
* ------------------------------------------------------------------------------
*/

provider "aws" {
  region      = "${var.region}"
  max_retries = 3
}

/*
* ------------------------------------------------------------------------------
* Modules
* ------------------------------------------------------------------------------
*/

# Network
module "network" {
  source = "github.com/scipian/quoins//network?ref=v0.0.13"
  cidr   = "${var.cidr}"
  name   = "${var.name}"
}

/*
* ------------------------------------------------------------------------------
* Data Sources
* ------------------------------------------------------------------------------
*/

data "aws_availability_zones" "available" {}

/*
* ------------------------------------------------------------------------------
* Outputs
* ------------------------------------------------------------------------------
*/

# The name of our quoin
output "name" {
  value = "${var.name}"
}

# The region where the quoin lives
output "region" {
  value = "${var.region}"
}

# A comma-separated list of availability zones for the network.
output "availability_zones" {
  value = "${join(",", data.aws_availability_zones.available.names)}"
}

# The Network ID
output "vpc_id" {
  value = "${module.network.vpc_id}"
}

# The CIDR used for the network
output "vpc_cidr" {
  value = "${module.network.vpc_cidr}"
}

# The Internet Gateway ID
output "internet_gateway_id" {
  value = "${module.network.internet_gateway_id}"
}
