locals {
  name                = "lake-loader-test"
  resource_group_name = "lake-loader-test-rg"
  location            = "North Europe"

  eh_namespace_name       = "lake-loader-test-eh-namespace"
  enriched_event_hub_name = "lake-loader-test-eh-enriched"
  bad_event_hub_name      = "lake-loader-test-eh-bad"

  storage_account_name   = "lakeloadertestsa"
  storage_container_name = "lake-loader-test-container"

  ssh_public_key = "<PUBLIC_KEY>"
}

resource "azurerm_resource_group" "group" {
  name     = local.resource_group_name
  location = local.location
}

module "eh_namespace" {
  source = "snowplow-devops/event-hub-namespace/azurerm"

  name                = local.eh_namespace_name
  resource_group_name = local.resource_group_name

  depends_on = [azurerm_resource_group.group]
}

module "enriched_event_hub" {
  source = "snowplow-devops/event-hub/azurerm"

  name                = local.enriched_event_hub_name
  namespace_name      = module.eh_namespace.name
  resource_group_name = local.resource_group_name
  partition_count     = 1
}

module "bad_event_hub" {
  source = "snowplow-devops/event-hub/azurerm"

  name                = local.bad_event_hub_name
  namespace_name      = module.eh_namespace.name
  resource_group_name = local.resource_group_name
  partition_count     = 1
}

module "storage_account" {
  source = "snowplow-devops/storage-account/azurerm"

  name                = local.storage_account_name
  resource_group_name = azurerm_resource_group.group.name

  depends_on = [azurerm_resource_group.group]
}

module "storage_container" {
  source = "snowplow-devops/storage-container/azurerm"

  name                 = local.storage_container_name
  storage_account_name = module.storage_account.name
}

resource "azurerm_virtual_network" "vnet" {
  name                = "example-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.group.location
  resource_group_name = azurerm_resource_group.group.name

  subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
  }
}

module "lake_loader_service" {
  source = "../.."

  name                = local.name
  resource_group_name = local.resource_group_name
  subnet_id           = tolist(azurerm_virtual_network.vnet.subnet)[0].id

  enriched_topic_name              = module.enriched_event_hub.name
  enriched_topic_connection_string = module.enriched_event_hub.read_only_primary_connection_string
  bad_topic_name                   = module.bad_event_hub.name
  bad_topic_connection_string      = module.bad_event_hub.read_write_primary_connection_string
  eh_namespace_name                = module.eh_namespace.name
  eh_namespace_broker              = module.eh_namespace.broker

  storage_account_name   = module.storage_account.name
  storage_container_name = module.storage_container.name

  ssh_public_key = local.ssh_public_key

  depends_on = [azurerm_resource_group.group, module.storage_container, module.storage_account]
}
