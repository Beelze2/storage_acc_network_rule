output "allowed_ips" {
  value = azurerm_storage_account_network_rules.sa_network_rule.ip_rules
}

output "allowed_subnets" {
  value = azurerm_storage_account_network_rules.sa_network_rule.virtual_network_subnet_ids
}

output "private_dns_zone_configs" {
  value = azurerm_private_endpoint.sa_private_endpoint.private_dns_zone_configs
}

output "custom_dns_configs" {
  value = azurerm_private_endpoint.sa_private_endpoint.custom_dns_configs
}

output "private_dns_zone_group" {
  value = azurerm_private_endpoint.sa_private_endpoint.private_dns_zone_group
}