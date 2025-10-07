resource "azurerm_cognitive_account" "AIServices" {
  name                               = var.ai_services_name
  location                           = var.location
  resource_group_name                = var.resource_group_name
  sku_name                           = var.ai_services_sku
  kind                               = "OpenAI"
  custom_subdomain_name              = var.ai_services_name
  outbound_network_access_restricted = var.outbound_network_access_restricted
  public_network_access_enabled              = var.ai_services_public_network_access

  network_acls {
    bypass         = var.network_acls.bypass
    default_action = var.network_acls.default_action
    ip_rules       = var.network_acls.ip_rules

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
  tags = var.tags
}

resource "azurerm_key_vault_secret" "aiServiceKey" {
  name         = "AZURE-AI-SERVICE-${upper(var.environment)}-KEY"
  value        = azurerm_cognitive_account.AIServices.primary_access_key
  key_vault_id = var.key_vault_id
}

resource "azurerm_key_vault_secret" "aiServiceEndpoint" {
  name         = "AZURE-AI-SERVICE-${upper(var.environment)}-EP"
  value        = azurerm_cognitive_account.AIServices.endpoint
  key_vault_id = var.key_vault_id
}

resource "azurerm_private_endpoint" "ai_service_pe" {
  for_each = { for idx, pe in var.ai_services_private_endpoints : idx => pe }

  name                = "${var.ai_services_name}-pe-${each.key}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = each.value.subnet_id

  private_service_connection {
    name                           = "${var.ai_services_name}-ai-service-${each.key}"
    private_connection_resource_id = azurerm_cognitive_account.AIServices.id
    subresource_names              = ["account"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group-${each.key}"
    private_dns_zone_ids = each.value.private_dns_zone_ids
  }
  tags = var.tags
}
#both key and azuread
resource "azapi_resource" "AIServicesConnectionAPIKey" {
  type      = "Microsoft.MachineLearningServices/workspaces/connections@2024-04-01-preview"
  name      = "${var.ai_services_name}-conn-apikey"
  parent_id = azurerm_ai_foundry.ai_hub.id

  body = {
    properties = {
      category      = "AIServices",
      target        = azurerm_cognitive_account.AIServices.endpoint,
      authType      = "ApiKey",
      isSharedToAll = true,
      credentials = {
        key = azurerm_cognitive_account.AIServices.primary_access_key # <<<<<< required when using APIKey auth
      },
      metadata = {
        ApiType    = "Azure",
        ResourceId = azurerm_cognitive_account.AIServices.id
      }
    }
  }
  response_export_values = ["*"]
  depends_on = [
    azurerm_cognitive_account.AIServices
  ]
}

resource "azapi_resource" "AIServicesConnectionEntraID" {
  type      = "Microsoft.MachineLearningServices/workspaces/connections@2024-04-01-preview"
  name      = "${var.ai_services_name}-conn-entraid"
  parent_id = azurerm_ai_foundry.ai_hub.id

  body = {
    properties = {
      category      = "AIServices",
      target        = azurerm_cognitive_account.AIServices.endpoint,
      authType      = "AAD",
      isSharedToAll = true,
      metadata = {
        ApiType    = "Azure",
        ResourceId = azurerm_cognitive_account.AIServices.id
      }
    }
  }
  response_export_values = ["*"]
  depends_on = [
    azurerm_cognitive_account.AIServices
  ]
}

resource "azurerm_role_assignment" "identity_access_to_ai_services" {
  principal_id = var.fa_principal_id
  scope        = azurerm_cognitive_account.AIServices.id

  role_definition_name = "Cognitive Services OpenAI User"
}
