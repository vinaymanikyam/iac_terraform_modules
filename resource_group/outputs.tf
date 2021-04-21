## Resource Group outputs
output "az_resource_group_name" {
  value = azurerm_resource_group.eventhub_resource_group.name
}


output "az_resource_group_id" {
  value = azurerm_resource_group.eventhub_resource_group.id
}

output "az_resource_group_location" {
  value = azurerm_resource_group.eventhub_resource_group.location
}