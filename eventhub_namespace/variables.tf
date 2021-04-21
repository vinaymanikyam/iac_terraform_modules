variable "resource_group_name" {

}

variable "location" {

}

variable "eventhub_namespace_name" {

}

variable "eventhub_sku" {
  default = "Standard"
}

variable "eventhub_zone_redundant" {

  default = true
}

variable "eventhub_capacity" {
  default = 1
}
variable "eventhub_message_retention" {
  default = 1
}

variable "eventhub_partition_count" {
  default = 2
}

variable "tags" {
  type = map
}

variable "auto_inflate_enabled" {


}

variable "whitelist_ips" {
  type = list(string)
}