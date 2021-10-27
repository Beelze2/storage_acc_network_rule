data "azurerm_resource_group" "rg" {
  name = var.rg_name
}

resource "azurerm_storage_account" "sa" {
  name                     = "${var.name_prefix_normalized}${var.unique_postfix}"
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = data.azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "container" {
  name                  = "container"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}

resource "azurerm_storage_account_network_rules" "sa_network_rule" {
  //resource_group_name = azurerm_resource_group.sa_network_rule_test.name
  storage_account_id = azurerm_storage_account.sa.id //will be depraceted and remover in 3.0 use storage_account_id

  default_action = "Deny"
  ip_rules       = var.sa_network_rule_ips // for ip range use CIDR format - https://www.ipaddressguide.com/cidr
  /*Small address ranges using "/31" or "/32" prefix sizes are not supported. These ranges should be configured using individual IP address rules without prefix specified.
  IP network rules have no effect on requests originating from the same Azure region as the storage account. Use Virtual network rules to allow same-region requests. */
  virtual_network_subnet_ids = var.sa_network_rule_subnet_ids
  bypass                     = ["Metrics"] // to remove set to []
}

resource "azurerm_private_endpoint" "sa_private_endpoint" {
  name                = "${var.name_prefix}_private_endpoint"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  subnet_id           = var.sa_private_endpoint_subnet_id

  private_service_connection {
    name                           = "${var.name_prefix}_private_serv_conn"
    private_connection_resource_id = azurerm_storage_account.sa.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "${var.name_prefix}_dns_zone_group"
    private_dns_zone_ids = var.sa_private_dns_zone_ids
  }
}