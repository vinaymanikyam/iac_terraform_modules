

resource "azurerm_eventhub_namespace" "eventhub_namespace" {
  name                = var.eventhub_namespace_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.eventhub_sku
  capacity            = var.eventhub_capacity
  zone_redundant      = var.eventhub_zone_redundant
  auto_inflate_enabled= var.auto_inflate_enabled

  network_rulesets {
    default_action = "Deny"
    ip_rule = [
      for ip in toset(var.whitelist_ips): {
        ip_mask = ip
        action = "Allow"
      }
    ] 

  }
  tags                = var.tags
}
