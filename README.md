[![Release][release-image]][release] [![CI][ci-image]][ci] [![License][license-image]][license] [![Registry][registry-image]][registry] [![Source][source-image]][source]

# terraform-azurerm-lake-loader-vmss

A Terraform module for saving Delta / Iceberg format files into Azure Blob Storage for direct querying by warehouses.

## Usage

See the `examples/default` directory for a working usage example of this module.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | >= 2.39.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.58.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | >= 2.39.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.58.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_service"></a> [service](#module\_service) | snowplow-devops/service-vmss/azurerm | 0.1.1 |
| <a name="module_telemetry"></a> [telemetry](#module\_telemetry) | snowplow-devops/telemetry/snowplow | 0.5.0 |

## Resources

| Name | Type |
|------|------|
| [azuread_application.app_registration](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [azuread_application_password.app_pasword](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_password) | resource |
| [azuread_service_principal.sp](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) | resource |
| [azurerm_eventhub_consumer_group.enriched_topic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_consumer_group) | resource |
| [azurerm_network_security_group.nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_rule.egress_tcp_443](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.egress_tcp_80](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.egress_udp_123](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.ingress_tcp_22](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_role_assignment.sc_app_ra](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/client_config) | data source |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_storage_container.sc](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_container) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bad_topic_kafka_password"></a> [bad\_topic\_kafka\_password](#input\_bad\_topic\_kafka\_password) | Password for connection to Kafka cluster under PlainLoginModule (note: as default the EventHubs topic connection string for writing is expected) | `string` | n/a | yes |
| <a name="input_bad_topic_name"></a> [bad\_topic\_name](#input\_bad\_topic\_name) | The name of the bad Event Hubs topic that the loader will push failures into | `string` | n/a | yes |
| <a name="input_enriched_topic_kafka_password"></a> [enriched\_topic\_kafka\_password](#input\_enriched\_topic\_kafka\_password) | Password for connection to Kafka cluster under PlainLoginModule (note: as default the EventHubs topic connection string for reading is expected) | `string` | n/a | yes |
| <a name="input_enriched_topic_name"></a> [enriched\_topic\_name](#input\_enriched\_topic\_name) | The name of the enriched Event Hubs topic that the loader will pull data from | `string` | n/a | yes |
| <a name="input_kafka_brokers"></a> [kafka\_brokers](#input\_kafka\_brokers) | The brokers to configure for access to the Kafka Cluster (note: as default the EventHubs namespace broker) | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | A name which will be pre-pended to the resources created | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group to deploy the service into | `string` | n/a | yes |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | The SSH public key attached for access to the servers | `string` | n/a | yes |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | Name of the output storage account | `string` | n/a | yes |
| <a name="input_storage_container_name"></a> [storage\_container\_name](#input\_storage\_container\_name) | Name of the output storage container | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The subnet id to deploy the service into | `string` | n/a | yes |
| <a name="input_app_version"></a> [app\_version](#input\_app\_version) | Lake Loader app version to use. This variable facilitates dev flow, the modules may not work with anything other than the default value. | `string` | `"0.1.3"` | no |
| <a name="input_associate_public_ip_address"></a> [associate\_public\_ip\_address](#input\_associate\_public\_ip\_address) | Whether to assign a public ip address to this instance | `bool` | `true` | no |
| <a name="input_bad_topic_kafka_username"></a> [bad\_topic\_kafka\_username](#input\_bad\_topic\_kafka\_username) | Username for connection to Kafka cluster under PlainLoginModule (default: '$ConnectionString' which is used for EventHubs) | `string` | `"$ConnectionString"` | no |
| <a name="input_custom_iglu_resolvers"></a> [custom\_iglu\_resolvers](#input\_custom\_iglu\_resolvers) | The custom Iglu Resolvers that will be used by Enrichment to resolve and validate events | <pre>list(object({<br>    name            = string<br>    priority        = number<br>    uri             = string<br>    api_key         = string<br>    vendor_prefixes = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_default_iglu_resolvers"></a> [default\_iglu\_resolvers](#input\_default\_iglu\_resolvers) | The default Iglu Resolvers that will be used by Enrichment to resolve and validate events | <pre>list(object({<br>    name            = string<br>    priority        = number<br>    uri             = string<br>    api_key         = string<br>    vendor_prefixes = list(string)<br>  }))</pre> | <pre>[<br>  {<br>    "api_key": "",<br>    "name": "Iglu Central",<br>    "priority": 10,<br>    "uri": "http://iglucentral.com",<br>    "vendor_prefixes": []<br>  },<br>  {<br>    "api_key": "",<br>    "name": "Iglu Central - Mirror 01",<br>    "priority": 20,<br>    "uri": "http://mirror01.iglucentral.com",<br>    "vendor_prefixes": []<br>  }<br>]</pre> | no |
| <a name="input_eh_namespace_name"></a> [eh\_namespace\_name](#input\_eh\_namespace\_name) | The name of the Event Hubs namespace (note: if you are not using EventHubs leave this blank) | `string` | `""` | no |
| <a name="input_enriched_topic_kafka_username"></a> [enriched\_topic\_kafka\_username](#input\_enriched\_topic\_kafka\_username) | Username for connection to Kafka cluster under PlainLoginModule (default: '$ConnectionString' which is used for EventHubs) | `string` | `"$ConnectionString"` | no |
| <a name="input_java_opts"></a> [java\_opts](#input\_java\_opts) | Custom JAVA Options | `string` | `"-XX:InitialRAMPercentage=75 -XX:MaxRAMPercentage=75"` | no |
| <a name="input_ssh_ip_allowlist"></a> [ssh\_ip\_allowlist](#input\_ssh\_ip\_allowlist) | The comma-seperated list of CIDR ranges to allow SSH traffic from | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_storage_container_path"></a> [storage\_container\_path](#input\_storage\_container\_path) | Path within the storage container to write output into | `string` | `"events/"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags to append to this resource | `map(string)` | `{}` | no |
| <a name="input_telemetry_enabled"></a> [telemetry\_enabled](#input\_telemetry\_enabled) | Whether or not to send telemetry information back to Snowplow Analytics Ltd | `bool` | `true` | no |
| <a name="input_user_provided_id"></a> [user\_provided\_id](#input\_user\_provided\_id) | An optional unique identifier to identify the telemetry events emitted by this stack | `string` | `""` | no |
| <a name="input_vm_instance_count"></a> [vm\_instance\_count](#input\_vm\_instance\_count) | The instance count to use | `number` | `1` | no |
| <a name="input_vm_sku"></a> [vm\_sku](#input\_vm\_sku) | The instance type to use | `string` | `"Standard_B2s"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nsg_id"></a> [nsg\_id](#output\_nsg\_id) | ID of the network security group attached to the Lake Loader Server nodes |
| <a name="output_vmss_id"></a> [vmss\_id](#output\_vmss\_id) | ID of the VM scale-set |

# Copyright and license

The Terraform Azurerm Lake Loader on VMSS project is Copyright 2023-present Snowplow Analytics Ltd.

Licensed under the [Snowplow Community License](https://docs.snowplow.io/community-license-1.0). _(If you are uncertain how it applies to your use case, check our answers to [frequently asked questions](https://docs.snowplow.io/docs/contributing/community-license-faq/).)_

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

[release]: https://github.com/snowplow-devops/terraform-azurerm-lake-loader-vmss/releases/latest
[release-image]: https://img.shields.io/github/v/release/snowplow-devops/terraform-azurerm-lake-loader-vmss

[ci]: https://github.com/snowplow-devops/terraform-azurerm-lake-loader-vmss/actions?query=workflow%3Aci
[ci-image]: https://github.com/snowplow-devops/terraform-azurerm-lake-loader-vmss/workflows/ci/badge.svg

[license]: https://docs.snowplow.io/docs/contributing/community-license-faq/
[license-image]: https://img.shields.io/badge/license-Snowplow--Community-blue.svg?style=flat

[registry]: https://registry.terraform.io/modules/snowplow-devops/lake-loader-vmss/azurerm/latest
[registry-image]: https://img.shields.io/static/v1?label=Terraform&message=Registry&color=7B42BC&logo=terraform

[source]: https://github.com/snowplow-incubator/snowplow-lake-loader
[source-image]: https://img.shields.io/static/v1?label=Snowplow&message=Lake%20Loader&color=0E9BA4&logo=GitHub
