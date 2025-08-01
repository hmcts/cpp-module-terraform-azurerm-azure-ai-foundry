resource "azurerm_ai_services" "AIServices" {
  name                = var.ai_services_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name = var.ai_services_sku
  custom_subdomain_name = "${var.ai_services_name}-${var.environment}"
  local_authentication_enabled = var.ai_services_local_authentication_enabled
  outbound_network_access_restricted = var.outbound_network_access_restricted
  public_network_access = var.ai_services_public_network_access

  network_acls {
    bypass          = var.network_acls.bypass
    default_action  = var.network_acls.default_action
    ip_rules        = var.network_acls.ip_rules

    dynamic "virtual_network_rules" {
      for_each = var.network_acls.virtual_network_subnet_ids == null ? [] : var.network_acls.virtual_network_subnet_ids
      content {
        subnet_id = virtual_network_rules.value
      }
    }
  }

  dynamic "identity" {
      for_each = var.identity == {} ? [] : [var.identity]
      content {
        type         = lookup(identity.value, "type", null)
        identity_ids = lookup(identity.value, "identity_ids", null)
      }
    }
  tags                         = var.tags
}

resource "azurerm_private_endpoint" "ai_service_pe" {
  for_each = { for idx, pe in var.ai_services_private_endpoints : idx => pe }

  name                = "${var.ai_services_name}-pe-${each.key}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = each.value.subnet_id

  private_service_connection {
    name                           = "${var.ai_services_name}-ai-service-${each.key}"
    private_connection_resource_id = azurerm_ai_services.AIServices.id
    subresource_names              = ["account"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group-${each.key}"
    private_dns_zone_ids = each.value.private_dns_zone_ids
  }
}

# resource "azapi_resource" "AIServicesConnection" {
#   type      = "Microsoft.MachineLearningServices/workspaces/connections@2024-04-01-preview"
#   name      = "platops-slack-help-bot-${var.env}"
#   parent_id = azurerm_machine_learning_workspace.hub.id
#
#   body = {
#     properties = {
#       category      = "AIServices",
#       target        = azurerm_ai_services.AIServices.endpoint,
#       authType      = "AAD",
#       isSharedToAll = true,
#       metadata = {
#         ApiType    = "Azure",
#         ResourceId = azurerm_ai_services.AIServices.id
#       }
#     }
#   }
#   response_export_values = ["*"]
# }
