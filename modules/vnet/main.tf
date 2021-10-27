data "azurerm_resource_group" "rg" {
  name = var.rg_name
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.name_prefix}_vnet"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location

  address_space = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "${var.name_prefix}_subnet"
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name

  address_prefixes = ["10.0.1.0/24"]

  service_endpoints = ["Microsoft.Storage"]

  enforce_private_link_endpoint_network_policies = true
}

resource "azurerm_private_dns_zone" "private_dns_zone" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = data.azurerm_resource_group.rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "private_dns_link" {
  name                  = "${var.name_prefix}_private_dns_link"
  resource_group_name   = data.azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
  registration_enabled  = true
}