# Eventhub outputs
output "az_eventhub_id" {
  description = "Azure event hub ID"
  value       = azurerm_eventhub.eventhub.id
}

output "az_eventhub_name" {
  description = "Azure event hub name"
  value       = azurerm_eventhub.eventhub.name
}