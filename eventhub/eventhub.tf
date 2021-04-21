

resource "azurerm_eventhub" "eventhub" {
  name                = var.eventhub_name
  namespace_name      = var.eventhub_namespace_name
  resource_group_name = var.resource_group_name
  partition_count     = var.eventhub_partition_count
  message_retention   = var.eventhub_message_retention
  capture_description {
    enabled = var.eventhub_capture_enabled
    encoding = var.eventhub_capture_encoding_type
    interval_in_seconds = var.eventhub_capture_interval_in_seconds
    size_limit_in_bytes = var.eventhub_capture_size_limit_in_bytes
    skip_empty_archives = var.eventhub_capture_skip_empty_archives
    destination {
      archive_name_format = var.eventhub_capture_archive_name_format
      blob_container_name =  var.eventhub_capture_blob_container_name
      name = var.eventhub_capture_destination_name
      storage_account_id = var.eventhub_capture_storage_account_id
    } 
    
  
  }


}


resource "azurerm_eventhub_consumer_group" "eventhub_consumer_group" {
  count               = var.create_custom_eventhub_group ? 1 : 0
  name                = var.eventhub_consumer_group
  namespace_name      = var.eventhub_namespace_name
  eventhub_name       = azurerm_eventhub.eventhub.name
  resource_group_name = var.resource_group_name

}


resource "azurerm_eventhub_authorization_rule" "eventhub" {
  count               = var.create_eventhub_authorization_rule ? 1 : 0
  name                = var.eventhub_authorization_rule_name
  namespace_name      = var.eventhub_namespace_name
  eventhub_name       = azurerm_eventhub.eventhub.name
  resource_group_name = var.resource_group_name
  listen              = var.eventhub_authorization_rule_listen
  send                = var.eventhub_authorization_rule_send
  manage              = var.eventhub_authorization_rule_manage
}
