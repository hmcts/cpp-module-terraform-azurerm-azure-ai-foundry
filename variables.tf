variable "location" {
  type    = string
  default = "uksouth"
}

variable "namespace" {
  type        = string
  default     = ""
  description = "Namespace, which could be an organization name or abbreviation, e.g. 'eg' or 'cp'"
}

variable "costcode" {
  type        = string
  description = "Name of theDWP PRJ number (obtained from the project portfolio in TechNow)"
  default     = ""
}

variable "owner" {
  type        = string
  description = "Name of the project or sqaud within the PDU which manages the resource. May be a persons name or email also"
  default     = ""
}


variable "application" {
  type        = string
  description = "Application to which the s3 bucket relates"
  default     = ""
}

variable "attribute" {
  type        = string
  description = "An attribute of the s3 bucket that makes it unique"
  default     = ""
}

variable "environment" {
  type        = string
  description = "Environment into which resource is deployed"
  default     = ""
}

variable "type" {
  type        = string
  description = "Name of service type"
  default     = ""
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the storage account. Changing this forces a new resource to be created."
  type        = string
}

variable "ai_hub" {
  description = "The name of ai hub"
  type        = string
}

variable "public_network_access" {
  description = "Whether the public network access is enabled"
  type        = string
}

variable "ai_hub_storage_account_id" {
  type = string
}

variable "ra_storage_account_id" {
  type = string
}

variable "key_vault_id" {
  type = string
}

variable "application_insights_id" {
  type = string
}


variable "sku_name" {
  default = "Basic"
}

variable "enable_system_assigned_identity" {
  type    = bool
  default = true
}

variable "enable_user_assigned_identity" {
  type    = bool
  default = false
}

variable "user_assigned_identity_id" {
  type    = string
  default = null
}

variable "enable_encryption" {
  type    = bool
  default = false
}

variable "encryption_key_vault_id" {
  type    = string
  default = null
}

variable "encryption_key_id" {
  type    = string
  default = null
}

# Managed Network
variable "enable_managed_network" {
  type    = bool
  default = false
}

variable "managed_network_isolation_mode" {
  type    = string
  default = "Disabled"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "project_description" {
  type    = string
  default = "AI hub project"
}

variable "project_name" {}

variable "enable_data_lookup" {
  description = "Enable lookup of private DNS zones"
  type        = bool
  default     = true
}

variable "private_dns_resource_group_name" {
  description = "Resource group where the private DNS zones are located"
  type        = string
  default     = "RG-DEV-SVC-01"
}
variable "subnet_ai" {
  description = "Subnet ID for the private endpoint"
  type        = string
}

variable "identity" {
  description = "Identity block Specifies the identity to assign to function app"
  type        = any
  default     = {}
}

variable "ai_search_service_name" {
  type        = string
  description = "Name of the Azure Cognitive Search service"
}

variable "ai_search_sku" {
  type        = string
  description = "SKU for Azure Cognitive Search. Possible values: 'free', 'basic', 'standard', etc."
  validation {
    condition     = contains(["free", "basic", "standard", "standard2", "standard3", "storage_optimized_l1", "storage_optimized_l2"], var.ai_search_sku)
    error_message = "Invalid SKU for Azure Cognitive Search."
  }
}

variable "replica_count" {
  type        = number
  default     = 1
  description = "Number of replicas (ignored for 'free' SKU)"
}

variable "partition_count" {
  type        = number
  default     = 1
  description = "Number of partitions (ignored for 'free' SKU)"
}

variable "hosting_mode" {
  type        = string
  default     = "default"
  description = "Hosting mode for the search service"
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Enable or disable public network access"
}

variable "allowed_ips" {
  type        = list(string)
  default     = []
  description = "List of allowed IP addresses (only used if public network access is enabled)"
}



variable "semantic_search_sku" {
  type        = string
  default     = null
  description = "SKU for semantic search (only applicable if SKU is not 'free')"
}

variable "authentication_failure_mode" {
  type        = string
  default     = "Http401WithBearerChallenge"
  description = "Specifies the authentication failure behavior (e.g., Http401WithBearerChallenge)"
}

variable "ai_hub_private_endpoints" {
  description = "List of private endpoints (internal + external)"
  type = list(object({
    private_dns_zone_ids            = list(string)
    subnet_id                       = string
    private_dns_resource_group_name = string
  }))
}

variable "ai_search_private_endpoints" {
  description = "List of private endpoints (internal + external)"
  type = list(object({
    private_dns_zone_ids            = list(string)
    subnet_id                       = string
    private_dns_resource_group_name = string
  }))
}

variable "ai_services_name" {
  description = "Name of the AI Services resource."
  type        = string
}

variable "ai_services_sku" {
  description = "SKU name for the AI Services resource (e.g., S0, S1)."
  type        = string
}


variable "ai_services_local_authentication_enabled" {
  description = "Enable or disable local authentication."
  type        = bool
  default     = true
}

variable "network_acls" {
  description = "Network access control settings for the AI Service."

  type = object({
    bypass                     = optional(string, "AzureServices") # or "None"
    default_action             = optional(string, "Deny")          # Must be "Allow" or "Deny"
    ip_rules                   = optional(list(string), [])        # List of IPs or CIDRs
    virtual_network_subnet_ids = optional(list(string), [])        # List of subnet IDs
  })

  default = {
    bypass                     = "AzureServices"
    default_action             = "Deny"
    ip_rules                   = []
    virtual_network_subnet_ids = []
  }
}

variable "outbound_network_access_restricted" {
  description = "Restrict outbound network access from the AI service."
  type        = bool
  default     = false
}

variable "ai_services_public_network_access" {
  description = "Public network access setting (Enabled or Disabled)."
  type        = string
}

variable "ai_services_private_endpoints" {
  description = "List of private endpoints (internal + external)"
  type = list(object({
    private_dns_zone_ids            = list(string)
    subnet_id                       = string
    private_dns_resource_group_name = string
  }))
}

variable "model_deployments" {
  type = map(object({
    model_name                 = string
    version                    = string
    format                     = string
    sku_name                   = string
    capacity                   = number
    dynamic_throttling_enabled = optional(string)
    version_upgrade_option     = optional(string)
    rai_policy_name            = optional(string)
  }))
}



# variable "indexes_json" {
#   type        = string
#   description = "Rendered JSON content for the indexes"
# }



variable "lookup_search_service" {
  type    = bool
  default = true
}

variable "document_intelligence_name" {
  description = "Name of the document intelligence"
  type        = string
}

variable "document_intelligence_sku" {
  type        = string
  default     = null
  description = "SKU for document intelligence"
}

variable "document_intelligence_public_network_access_enabled" {
  type        = bool
  description = "Enable or disable public network access"
}

variable "document_intelligence_private_endpoints" {
  description = "List of private endpoints (internal + external)"
  type = list(object({
    private_dns_zone_ids            = list(string)
    subnet_id                       = string
    private_dns_resource_group_name = string
  }))
}

variable "fa_principal_id" {
  description = "Function app user assigned identity for accessing ai search"
  type        = string
}
