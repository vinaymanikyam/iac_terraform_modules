#######################################################################################
###############         Manages a Resource Group             #####################
#######################################################################################

resource "azurerm_resource_group" "eventhub_resource_group" {
  name                = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

