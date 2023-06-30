## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bad_event_hub"></a> [bad\_event\_hub](#module\_bad\_event\_hub) | snowplow-devops/event-hub/azurerm | n/a |
| <a name="module_eh_namespace"></a> [eh\_namespace](#module\_eh\_namespace) | snowplow-devops/event-hub-namespace/azurerm | n/a |
| <a name="module_enriched_event_hub"></a> [enriched\_event\_hub](#module\_enriched\_event\_hub) | snowplow-devops/event-hub/azurerm | n/a |
| <a name="module_lake_loader_service"></a> [lake\_loader\_service](#module\_lake\_loader\_service) | ../.. | n/a |
| <a name="module_storage_account"></a> [storage\_account](#module\_storage\_account) | snowplow-devops/storage-account/azurerm | n/a |
| <a name="module_storage_container"></a> [storage\_container](#module\_storage\_container) | snowplow-devops/storage-container/azurerm | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nsg_id"></a> [nsg\_id](#output\_nsg\_id) | ID of the network security group attached to the Lake Loader Server nodes |
| <a name="output_vmss_id"></a> [vmss\_id](#output\_vmss\_id) | ID of the VM scale-set |
