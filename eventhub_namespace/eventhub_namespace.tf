#######################################################################################
###############   Manages an EventHub Namespace and whitelsit the ip's    #############
#######################################################################################

resource "azurerm_eventhub_namespace" "eventhub_namespace" {
  name                = var.eventhub_namespace_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.eventhub_sku                   //Defines which tier to use. Valid options are Basic and Standard.
  capacity            = var.eventhub_capacity              //Specifies the Capacity / Throughput Units for a Standard SKU namespace. Default capacity has a maximum of 20, but can be increased in blocks of 20 on a committed purchase basis.
  zone_redundant      = var.eventhub_zone_redundant        //Specifies if the EventHub Namespace should be Zone Redundant (created across Availability Zones). Changing this forces a new resource to be created. Defaults to false.
  auto_inflate_enabled= var.auto_inflate_enabled           // Is Auto Inflate enabled for the EventHub Namespace?

  network_rulesets {                                       //A network_rulesets block as defined below.
    default_action = "Deny"                                //The default action to take when a rule is not matched. Possible values are Allow and Deny. Defaults to Deny.
    ip_rule = [
      for ip in toset(var.whitelist_ips): {
        ip_mask = ip
        action = "Allow"
      }
    ] 

  }
  tags                = var.tags
}
