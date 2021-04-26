#######################################################################################
##   Manages a Event Hubs as a nested resource within a Event Hubs namespace    #######
#######################################################################################

resource "azurerm_eventhub" "eventhub" {
  name                    = var.eventhub_name
  namespace_name          = var.eventhub_namespace_name
  resource_group_name     = var.resource_group_name
  partition_count         = var.eventhub_partition_count                    // Specifies the current number of shards on the Event Hub. Changing this forces a new resource to be created.
  message_retention       = var.eventhub_message_retention                  // Specifies the number of days to retain the events for this Event Hub.
  capture_description {
    enabled               = var.eventhub_capture_enabled                    //Specifies if the Capture Description is Enabled.
    encoding              = var.eventhub_capture_encoding_type              //Specifies the Encoding used for the Capture Description. Possible values are Avro and AvroDeflate.
    interval_in_seconds   = var.eventhub_capture_interval_in_seconds        //Specifies the time interval in seconds at which the capture will happen. Values can be between 60 and 900 seconds. Defaults to 300 seconds.
    size_limit_in_bytes   = var.eventhub_capture_size_limit_in_bytes        //Specifies the amount of data built up in your EventHub before a Capture Operation occurs. Value should be between 10485760 and 524288000 bytes. Defaults to 314572800 bytes.
    skip_empty_archives   = var.eventhub_capture_skip_empty_archives        //Specifies if empty files should not be emitted if no events occur during the Capture time window. Defaults to false.
    destination {
      archive_name_format = var.eventhub_capture_archive_name_format        //The Blob naming convention for archiving. e.g. {Namespace}/{EventHub}/{PartitionId}/{Year}/{Month}/{Day}/{Hour}/{Minute}/{Second}. Here all the parameters (Namespace,EventHub .. etc) are mandatory irrespective of order
      blob_container_name = azurerm_storage_container.storage_container.name//The name of the Container within the Blob Storage Account where messages should be archived.
      name                = var.eventhub_capture_destination_name
      storage_account_id  = var.storage_account_id                          //The ID of the Blob Storage Account where messages should be archived.
    } 
    
  
  }


}


resource "azurerm_eventhub_consumer_group" "eventhub_consumer_group" {
  count               = var.create_custom_eventhub_group ? 1 : 0
  name                = var.eventhub_consumer_group                         //Specifies the name of the EventHub Consumer Group resource. Changing this forces a new resource to be created.
  namespace_name      = var.eventhub_namespace_name                         //Specifies the name of the grandparent EventHub Namespace. Changing this forces a new resource to be created.
  eventhub_name       = azurerm_eventhub.eventhub.name                      //Specifies the name of the EventHub. Changing this forces a new resource to be created.
  resource_group_name = var.resource_group_name                             //The name of the resource group in which the EventHub Consumer Group's grandparent Namespace exists. Changing this forces a new resource to be created.

}


resource "azurerm_eventhub_authorization_rule" "eventhub" {
  count               = var.create_eventhub_authorization_rule ? 1 : 0
  name                = var.eventhub_authorization_rule_name
  namespace_name      = var.eventhub_namespace_name
  eventhub_name       = azurerm_eventhub.eventhub.name
  resource_group_name = var.resource_group_name
  listen              = var.eventhub_authorization_rule_listen              //Does this Authorization Rule have permissions to Listen to the Event Hub? Defaults to false.
  send                = var.eventhub_authorization_rule_send                //Does this Authorization Rule have permissions to Send to the Event Hub? Defaults to false.
  manage              = var.eventhub_authorization_rule_manage              //Does this Authorization Rule have permissions to Manage to the Event Hub? When this property is true - both listen and send must be too. Defaults to false.
}



resource "azurerm_storage_container" "storage_container" {
  name                  =  var.storage_container_name
  storage_account_name  =  var.storage_account_name
  container_access_type =  var.storage_container_access_type                //The Access Level configured for this Container. Possible values are blob, container or private. Defaults to private.
} 