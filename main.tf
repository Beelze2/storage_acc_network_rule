terraform {
  required_providers {
    azurerm = {
    }
  }
}

provider "azurerm" {
  features {

  }
}

resource "azurerm_resource_group" "sa_network_rule_test" {
  name     = "${var.name_prefix}_RG"
  location = var.region
}

module "vnet" {
  source = "./modules/vnet"

  rg_name     = azurerm_resource_group.sa_network_rule_test.name
  name_prefix = var.name_prefix

  depends_on = [
    azurerm_resource_group.sa_network_rule_test
  ]
}

module "sa" {
  source = "./modules/storage_account"

  rg_name                       = azurerm_resource_group.sa_network_rule_test.name
  name_prefix                   = var.name_prefix
  name_prefix_normalized        = var.name_prefix_normalized
  unique_postfix                = var.unique_postfix
  sa_network_rule_ips           = var.sa_network_rule_ips
  sa_network_rule_subnet_ids    = [] //[module.vnet.subnet_id]
  sa_private_endpoint_subnet_id = module.vnet.subnet_id
  sa_private_dns_zone_ids       = [module.vnet.dns_zone_id]

  depends_on = [
    azurerm_resource_group.sa_network_rule_test,
    module.vnet
  ]
}

module "vm" {
  source = "./modules/vm"

  rg_name          = azurerm_resource_group.sa_network_rule_test.name
  name_prefix      = var.name_prefix
  vnet_name        = module.vnet.vnet_name
  vnet_subnet_name = module.vnet.subnet_name

  depends_on = [
    module.vnet
  ]
}