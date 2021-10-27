variable "name_prefix" {
  type    = string
  default = "sa_network_rule_test"
}

variable "name_prefix_normalized" {
  type    = string
  default = "sanetworkruletest"
}

variable "unique_postfix" {
  type    = string
  default = "stvo99"
}

variable "region" {
  type    = string
  default = "West Europe"
}

variable "sa_network_rule_ips" {
  type    = list(string)
  default = ["132.168.2.6", "89.25.78.70"]
}