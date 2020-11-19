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

variable pkeys {
    description = "Mapping for PRIVATE keys"
    default = {
	"inita" = "5KK65pGgYbUzdnWCUQ5FZ6QyhahF3ymtpf5zkv43h7HmLrAmdr5"
	"initb" = "5J48uZZVdmRxAn8sbosnwG293NnfJ3QG38jGLKJUzfpWajKdYWR"
	"initc" = "5Khaw3mn1C7xkbRb33qdvADHNkYRaSWrC62tMjdYZGxWczsj6gZ"
	"initd" = "5Jus9N9Skvc2GL6zaSrfdBHZZwUwiUJmWCpofPgMTwB2Px7ZAPD"
    }
}

variable pubs {
    description = "Mapping for PUBLIC keys"
    default = {
	"inita" = "EOS5zCg5bMvi4AWugeKmiQD5iQtjSrGKdSodTPXnQMYNdeDAm7w2N"
        "initb" = "EOS6PNy7RbvX1Tj55N7GXFJbwGCmjuDVFDxC224g36MyWTDsUpzbz"
	"initc" = "EOS7EXJSLeL3nSmweidjDG9tkeimmYQpt7MCjWiEfP6wDzWYJrSkH"
	"initd" = "EOS6W52PxQiFvWPt9DQnK5qdKXdWoJZNWbPdhXE9fBpqx554S2Zre"
    }
}
