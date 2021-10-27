variable "rg_name" {
  type = string
}

variable "name_prefix" {
  type = string
}

variable "name_prefix_normalized" {
  type = string
}

variable "unique_postfix" {
  type = string
}

variable "sa_network_rule_ips" {
  type = list(string)
}

variable "sa_network_rule_subnet_ids" {
  type = list(string)
}

variable "sa_private_endpoint_subnet_id" {
  type = string
}

variable "sa_private_dns_zone_ids" {
  type = list(string)
}