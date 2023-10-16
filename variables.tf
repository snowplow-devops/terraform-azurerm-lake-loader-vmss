variable "name" {
  description = "A name which will be pre-pended to the resources created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group to deploy the service into"
  type        = string
}

variable "app_version" {
  description = "Lake Loader app version to use. This variable facilitates dev flow, the modules may not work with anything other than the default value."
  type        = string
  default     = "0.1.3"
}

variable "subnet_id" {
  description = "The subnet id to deploy the service into"
  type        = string
}

variable "vm_sku" {
  description = "The instance type to use"
  type        = string
  default     = "Standard_B2s"
}

variable "vm_instance_count" {
  description = "The instance count to use"
  type        = number
  default     = 1
}

variable "associate_public_ip_address" {
  description = "Whether to assign a public ip address to this instance"
  type        = bool
  default     = true
}

variable "ssh_public_key" {
  description = "The SSH public key attached for access to the servers"
  type        = string
}

variable "ssh_ip_allowlist" {
  description = "The comma-seperated list of CIDR ranges to allow SSH traffic from"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "tags" {
  description = "The tags to append to this resource"
  default     = {}
  type        = map(string)
}

variable "java_opts" {
  description = "Custom JAVA Options"
  default     = "-XX:InitialRAMPercentage=75 -XX:MaxRAMPercentage=75"
  type        = string
}

# --- Configuration options

variable "enriched_topic_name" {
  description = "The name of the enriched Event Hubs topic that the loader will pull data from"
  type        = string
}

variable "enriched_topic_kafka_username" {
  description = "Username for connection to Kafka cluster under PlainLoginModule (default: '$ConnectionString' which is used for EventHubs)"
  type        = string
  default     = "$ConnectionString"
}

variable "enriched_topic_kafka_password" {
  description = "Password for connection to Kafka cluster under PlainLoginModule (note: as default the EventHubs topic connection string for reading is expected)"
  type        = string
}

variable "bad_topic_name" {
  description = "The name of the bad Event Hubs topic that the loader will push failures into"
  type        = string
}

variable "bad_topic_kafka_username" {
  description = "Username for connection to Kafka cluster under PlainLoginModule (default: '$ConnectionString' which is used for EventHubs)"
  type        = string
  default     = "$ConnectionString"
}

variable "bad_topic_kafka_password" {
  description = "Password for connection to Kafka cluster under PlainLoginModule (note: as default the EventHubs topic connection string for writing is expected)"
  type        = string
}

variable "eh_namespace_name" {
  description = "The name of the Event Hubs namespace (note: if you are not using EventHubs leave this blank)"
  type        = string
  default     = ""
}

variable "kafka_brokers" {
  description = "The brokers to configure for access to the Kafka Cluster (note: as default the EventHubs namespace broker)"
  type        = string
}

variable "storage_account_name" {
  description = "Name of the output storage account"
  type        = string
}

variable "storage_container_name" {
  description = "Name of the output storage container"
  type        = string
}

variable "storage_container_path" {
  description = "Path within the storage container to write output into"
  type        = string
  default     = "events/"
}

# --- Iglu Resolver

variable "default_iglu_resolvers" {
  description = "The default Iglu Resolvers that will be used by Enrichment to resolve and validate events"
  default = [
    {
      name            = "Iglu Central"
      priority        = 10
      uri             = "http://iglucentral.com"
      api_key         = ""
      vendor_prefixes = []
    },
    {
      name            = "Iglu Central - Mirror 01"
      priority        = 20
      uri             = "http://mirror01.iglucentral.com"
      api_key         = ""
      vendor_prefixes = []
    }
  ]
  type = list(object({
    name            = string
    priority        = number
    uri             = string
    api_key         = string
    vendor_prefixes = list(string)
  }))
}

variable "custom_iglu_resolvers" {
  description = "The custom Iglu Resolvers that will be used by Enrichment to resolve and validate events"
  default     = []
  type = list(object({
    name            = string
    priority        = number
    uri             = string
    api_key         = string
    vendor_prefixes = list(string)
  }))
}

# --- Telemetry

variable "kafka_source" {
  description = "The source providing the Kafka connectivity (def: azure_event_hubs)"
  default     = "azure_event_hubs"
  type        = string
}

variable "telemetry_enabled" {
  description = "Whether or not to send telemetry information back to Snowplow Analytics Ltd"
  type        = bool
  default     = true
}

variable "user_provided_id" {
  description = "An optional unique identifier to identify the telemetry events emitted by this stack"
  type        = string
  default     = ""
}
