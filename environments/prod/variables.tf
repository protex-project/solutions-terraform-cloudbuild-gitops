variable "project" {}
variable "region" {}
variable "zone" {}

variable "network" {}
variable "subnetwork" {}

variable "node_name" {
    type 	= string
    description = "Enter the name of new server"
}
variable "machine_type" {}

variable "producer_name" {
    type 	= string
    description = "Choise producer name (inita, initb, initc, initd):"
    validation {
	condition = contains(["inita", "initb", "initc", "initd"], lower(var.producer_name))
	error_message = "Unsupported producer name."
    }
}

variable "producer_pkey" {
    type	= string
    description = "Enter producer PRIVATE key:"
}

variable "producer_pub" {
    type	= string
    description = "Enter producer PUBLIC key:"
}
