# terraform-module-template

<!-- TODO fill in resource name in link to product documentation -->
Terraform module for [Resource name](https://example.com).

## Example

<!-- todo update module name
```hcl
module "todo_resource_name" {
  source = "git@github.com:hmcts/terraform-module-postgresql-flexible?ref=master"
  ...
}

```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | 2.4.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.34.0 |
| <a name="requirement_restapi"></a> [restapi](#requirement\_restapi) | 2.0.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azapi"></a> [azapi](#provider\_azapi) | 2.4.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.34.0 |
| <a name="provider_http"></a> [http](#provider\_http) | 3.5.0 |
| <a name="provider_restapi"></a> [restapi](#provider\_restapi) | 2.0.1 |
| <a name="provider_time"></a> [time](#provider\_time) | 0.13.1 |

## Resources

| Name | Type |
|------|------|
| [azapi_resource.AIServicesConnectionAPIKey](https://registry.terraform.io/providers/Azure/azapi/2.4.0/docs/resources/resource) | resource |
| [azapi_resource.AIServicesConnectionEntraID](https://registry.terraform.io/providers/Azure/azapi/2.4.0/docs/resources/resource) | resource |
| [azurerm_ai_foundry.ai_hub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/ai_foundry) | resource |
| [azurerm_ai_foundry_project.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/ai_foundry_project) | resource |
| [azurerm_ai_services.AIServices](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/ai_services) | resource |
| [azurerm_cognitive_account.formRecognizerAccount](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cognitive_account) | resource |
| [azurerm_cognitive_deployment.models](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cognitive_deployment) | resource |
| [azurerm_key_vault_secret.aiSearchEndpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.aiSearchKey](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.aiServiceEndpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.aiServiceKey](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.docIntelligenceEndpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.docIntelligenceKey](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_private_endpoint.ai_document_intelligence_pe](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.ai_search_pe](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.ai_service_pe](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.ws_pe](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_role_assignment.identity_access_to_ai_services](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.identity_access_to_sa](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.search_index_data_reader](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.search_index_data_reader_3](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_search_service.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/search_service) | resource |
| [restapi_object.ai_search_indexes](https://registry.terraform.io/providers/Mastercard/restapi/2.0.1/docs/resources/object) | resource |
| [time_sleep.wait_for_ai_service](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [time_sleep.wait_for_search_service](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [http_http.ai_search_index_json](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ai_hub"></a> [ai\_hub](#input\_ai\_hub) | The name of ai hub | `string` | n/a | yes |
| <a name="input_ai_hub_private_endpoints"></a> [ai\_hub\_private\_endpoints](#input\_ai\_hub\_private\_endpoints) | List of private endpoints (internal + external) | <pre>list(object({<br/>    private_dns_zone_ids            = list(string)<br/>    subnet_id                       = string<br/>    private_dns_resource_group_name = string<br/>  }))</pre> | n/a | yes |
| <a name="input_ai_hub_storage_account_id"></a> [ai\_hub\_storage\_account\_id](#input\_ai\_hub\_storage\_account\_id) | n/a | `string` | n/a | yes |
| <a name="input_ai_search_private_endpoints"></a> [ai\_search\_private\_endpoints](#input\_ai\_search\_private\_endpoints) | List of private endpoints (internal + external) | <pre>list(object({<br/>    private_dns_zone_ids            = list(string)<br/>    subnet_id                       = string<br/>    private_dns_resource_group_name = string<br/>  }))</pre> | n/a | yes |
| <a name="input_ai_search_service_name"></a> [ai\_search\_service\_name](#input\_ai\_search\_service\_name) | Name of the Azure Cognitive Search service | `string` | n/a | yes |
| <a name="input_ai_search_sku"></a> [ai\_search\_sku](#input\_ai\_search\_sku) | SKU for Azure Cognitive Search. Possible values: 'free', 'basic', 'standard', etc. | `string` | n/a | yes |
| <a name="input_ai_services_local_authentication_enabled"></a> [ai\_services\_local\_authentication\_enabled](#input\_ai\_services\_local\_authentication\_enabled) | Enable or disable local authentication. | `bool` | `true` | no |
| <a name="input_ai_services_name"></a> [ai\_services\_name](#input\_ai\_services\_name) | Name of the AI Services resource. | `string` | n/a | yes |
| <a name="input_ai_services_private_endpoints"></a> [ai\_services\_private\_endpoints](#input\_ai\_services\_private\_endpoints) | List of private endpoints (internal + external) | <pre>list(object({<br/>    private_dns_zone_ids            = list(string)<br/>    subnet_id                       = string<br/>    private_dns_resource_group_name = string<br/>  }))</pre> | n/a | yes |
| <a name="input_ai_services_public_network_access"></a> [ai\_services\_public\_network\_access](#input\_ai\_services\_public\_network\_access) | Public network access setting (Enabled or Disabled). | `string` | n/a | yes |
| <a name="input_ai_services_sku"></a> [ai\_services\_sku](#input\_ai\_services\_sku) | SKU name for the AI Services resource (e.g., S0, S1). | `string` | n/a | yes |
| <a name="input_allowed_ips"></a> [allowed\_ips](#input\_allowed\_ips) | List of allowed IP addresses (only used if public network access is enabled) | `list(string)` | `[]` | no |
| <a name="input_application"></a> [application](#input\_application) | Application to which the s3 bucket relates | `string` | `""` | no |
| <a name="input_application_insights_id"></a> [application\_insights\_id](#input\_application\_insights\_id) | n/a | `string` | n/a | yes |
| <a name="input_attribute"></a> [attribute](#input\_attribute) | An attribute of the s3 bucket that makes it unique | `string` | `""` | no |
| <a name="input_authentication_failure_mode"></a> [authentication\_failure\_mode](#input\_authentication\_failure\_mode) | Specifies the authentication failure behavior (e.g., Http401WithBearerChallenge) | `string` | `"Http401WithBearerChallenge"` | no |
| <a name="input_costcode"></a> [costcode](#input\_costcode) | Name of theDWP PRJ number (obtained from the project portfolio in TechNow) | `string` | `""` | no |
| <a name="input_document_intelligence_name"></a> [document\_intelligence\_name](#input\_document\_intelligence\_name) | Name of the document intelligence | `string` | n/a | yes |
| <a name="input_document_intelligence_private_endpoints"></a> [document\_intelligence\_private\_endpoints](#input\_document\_intelligence\_private\_endpoints) | List of private endpoints (internal + external) | <pre>list(object({<br/>    private_dns_zone_ids            = list(string)<br/>    subnet_id                       = string<br/>    private_dns_resource_group_name = string<br/>  }))</pre> | n/a | yes |
| <a name="input_document_intelligence_public_network_access_enabled"></a> [document\_intelligence\_public\_network\_access\_enabled](#input\_document\_intelligence\_public\_network\_access\_enabled) | Enable or disable public network access | `bool` | n/a | yes |
| <a name="input_document_intelligence_sku"></a> [document\_intelligence\_sku](#input\_document\_intelligence\_sku) | SKU for document intelligence | `string` | `null` | no |
| <a name="input_enable_data_lookup"></a> [enable\_data\_lookup](#input\_enable\_data\_lookup) | Enable lookup of private DNS zones | `bool` | `true` | no |
| <a name="input_enable_encryption"></a> [enable\_encryption](#input\_enable\_encryption) | n/a | `bool` | `false` | no |
| <a name="input_enable_managed_network"></a> [enable\_managed\_network](#input\_enable\_managed\_network) | Managed Network | `bool` | `false` | no |
| <a name="input_enable_system_assigned_identity"></a> [enable\_system\_assigned\_identity](#input\_enable\_system\_assigned\_identity) | n/a | `bool` | `true` | no |
| <a name="input_enable_user_assigned_identity"></a> [enable\_user\_assigned\_identity](#input\_enable\_user\_assigned\_identity) | n/a | `bool` | `false` | no |
| <a name="input_encryption_key_id"></a> [encryption\_key\_id](#input\_encryption\_key\_id) | n/a | `string` | `null` | no |
| <a name="input_encryption_key_vault_id"></a> [encryption\_key\_vault\_id](#input\_encryption\_key\_vault\_id) | n/a | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment into which resource is deployed | `string` | `""` | no |
| <a name="input_fa_principal_id"></a> [fa\_principal\_id](#input\_fa\_principal\_id) | Function app user assigned identity for accessing ai search | `string` | n/a | yes |
| <a name="input_hosting_mode"></a> [hosting\_mode](#input\_hosting\_mode) | Hosting mode for the search service | `string` | `"default"` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | Identity block Specifies the identity to assign to function app | `any` | `{}` | no |
| <a name="input_key_vault_id"></a> [key\_vault\_id](#input\_key\_vault\_id) | n/a | `string` | n/a | yes |
| <a name="input_local_authentication_enabled"></a> [local\_authentication\_enabled](#input\_local\_authentication\_enabled) | Whether local (API key) authentication is enabled | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | `"uksouth"` | no |
| <a name="input_lookup_search_service"></a> [lookup\_search\_service](#input\_lookup\_search\_service) | n/a | `bool` | `true` | no |
| <a name="input_managed_network_isolation_mode"></a> [managed\_network\_isolation\_mode](#input\_managed\_network\_isolation\_mode) | n/a | `string` | `"Disabled"` | no |
| <a name="input_model_deployments"></a> [model\_deployments](#input\_model\_deployments) | n/a | <pre>map(object({<br/>    model_name                 = string<br/>    version                    = string<br/>    format                     = string<br/>    sku_name                   = string<br/>    capacity                   = number<br/>    dynamic_throttling_enabled = optional(string)<br/>    version_upgrade_option     = optional(string)<br/>    rai_policy_name            = optional(string)<br/>  }))</pre> | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace, which could be an organization name or abbreviation, e.g. 'eg' or 'cp' | `string` | `""` | no |
| <a name="input_network_acls"></a> [network\_acls](#input\_network\_acls) | Network access control settings for the AI Service. | <pre>object({<br/>    bypass                     = optional(string, "AzureServices") # or "None"<br/>    default_action             = optional(string, "Deny")          # Must be "Allow" or "Deny"<br/>    ip_rules                   = optional(list(string), [])        # List of IPs or CIDRs<br/>    virtual_network_subnet_ids = optional(list(string), [])        # List of subnet IDs<br/>  })</pre> | <pre>{<br/>  "bypass": "AzureServices",<br/>  "default_action": "Deny",<br/>  "ip_rules": [],<br/>  "virtual_network_subnet_ids": []<br/>}</pre> | no |
| <a name="input_outbound_network_access_restricted"></a> [outbound\_network\_access\_restricted](#input\_outbound\_network\_access\_restricted) | Restrict outbound network access from the AI service. | `bool` | `false` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | Name of the project or sqaud within the PDU which manages the resource. May be a persons name or email also | `string` | `""` | no |
| <a name="input_partition_count"></a> [partition\_count](#input\_partition\_count) | Number of partitions (ignored for 'free' SKU) | `number` | `1` | no |
| <a name="input_private_dns_resource_group_name"></a> [private\_dns\_resource\_group\_name](#input\_private\_dns\_resource\_group\_name) | Resource group where the private DNS zones are located | `string` | `"RG-DEV-SVC-01"` | no |
| <a name="input_project_description"></a> [project\_description](#input\_project\_description) | n/a | `string` | `"AI hub project"` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | n/a | `any` | n/a | yes |
| <a name="input_public_network_access"></a> [public\_network\_access](#input\_public\_network\_access) | Whether the public network access is enabled | `string` | n/a | yes |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Enable or disable public network access | `bool` | n/a | yes |
| <a name="input_ra_storage_account_id"></a> [ra\_storage\_account\_id](#input\_ra\_storage\_account\_id) | n/a | `string` | n/a | yes |
| <a name="input_replica_count"></a> [replica\_count](#input\_replica\_count) | Number of replicas (ignored for 'free' SKU) | `number` | `1` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the storage account. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_semantic_search_sku"></a> [semantic\_search\_sku](#input\_semantic\_search\_sku) | SKU for semantic search (only applicable if SKU is not 'free') | `string` | `null` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | n/a | `string` | `"Basic"` | no |
| <a name="input_subnet_ai"></a> [subnet\_ai](#input\_subnet\_ai) | Subnet ID for the private endpoint | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_type"></a> [type](#input\_type) | Name of service type | `string` | `""` | no |
| <a name="input_user_assigned_identity_id"></a> [user\_assigned\_identity\_id](#input\_user\_assigned\_identity\_id) | n/a | `string` | `null` | no |
<!-- END_TF_DOCS -->

## Contributing

We use pre-commit hooks for validating the terraform format and maintaining the documentation automatically.
Install it with:

```shell
$ brew install pre-commit terraform-docs
$ pre-commit install
```

If you add a new hook make sure to run it against all files:
```shell
$ pre-commit run --all-files
```
