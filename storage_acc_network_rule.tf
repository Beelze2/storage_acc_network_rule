/*resource "azurerm_storage_account_network_rules" "sa_network_rule" {
  resource_group_name  = var.resource_group_name
  storage_account_name = var.storage_account_name //will be depraceted and remover in 3.0 use storage_account_id

  default_action = "Deny"
  ip_rules       = ["127.0.0.1"] // for ip range use CIDR format - https://www.ipaddressguide.com/cidr
  /*Small address ranges using "/31" or "/32" prefix sizes are not supported. These ranges should be configured using individual IP address rules without prefix specified.
  IP network rules have no effect on requests originating from the same Azure region as the storage account. Use Virtual network rules to allow same-region requests. */
/*virtual_network_subnet_ids = []
  bypass                     = ["Metrics"] // to remove set to []
}*/