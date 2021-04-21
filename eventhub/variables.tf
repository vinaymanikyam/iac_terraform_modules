variable "resource_group_name" {

}

variable "location" {

}

variable "eventhub_namespace_name" {

}

variable "eventhub_name" {}


variable "eventhub_message_retention" {
  default = 1
}

variable "eventhub_partition_count" {
  default = 2
}

variable "tags" {
  type = map
}

variable "eventhub_consumer_group" {

}

variable "create_custom_eventhub_group" {}

variable "create_eventhub_authorization_rule" {

}

variable "eventhub_authorization_rule_name" {}

variable "eventhub_authorization_rule_listen" {
  description = "Grants listen access to Authorization Rule of the Event Hub namespace"
  type        = bool
}

variable "eventhub_authorization_rule_send" {
  description = "Grants send access to Authorization Rule of the Event Hub namespace"
  type        = bool
}

variable "eventhub_authorization_rule_manage" {
  description = "Grants manage access to Authorization Rule of the Event Hub namespace"
  type        = bool
}

variable "eventhub_capture_size_limit_in_bytes" {
  default = 1000000
}

variable "eventhub_capture_interval_in_seconds" {

}