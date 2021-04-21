## Eventhub Namespace outputs
output "az_eventhub_namespace_id" {
  description = "Azure event hub namespace ID"
  value       = azurerm_eventhub_namespace.eventhub_namespace.id
}

output "az_eventhub_namespace_name" {
  description = "Azure event hub namespace name"
  value       = azurerm_eventhub_namespace.eventhub_namespace.name
}
