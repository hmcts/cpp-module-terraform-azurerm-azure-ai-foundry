resource "azurerm_search_service" "main" {
  name                = var.ai_search_service_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.ai_search_sku #basic and free in shared cluster, standard requires a dedicated cluster wat is that ?

  replica_count                 = var.replica_count
  partition_count               = var.partition_count
  hosting_mode                  = var.hosting_mode
  public_network_access_enabled = var.public_network_access_enabled
  allowed_ips                   = var.public_network_access_enabled ? var.allowed_ips : null

  dynamic "identity" {
    for_each = var.identity == {} ? [] : [var.identity]
    content {
      type         = lookup(identity.value, "type", null)
      identity_ids = lookup(identity.value, "identity_ids", null)
    }
  }

  semantic_search_sku = var.ai_search_sku != "free" ? var.semantic_search_sku : null

  local_authentication_enabled = var.local_authentication_enabled
  authentication_failure_mode  = var.local_authentication_enabled ? var.authentication_failure_mode : null
  tags                         = var.tags
}

resource "azurerm_key_vault_secret" "aiSearchKey" {
  name         = "AZURE-AI-SEARCH-SERVICE-KEY"
  value        = azurerm_search_service.main.primary_key
  key_vault_id = var.key_vault_id
}



resource "azurerm_private_endpoint" "ai_search_pe" {
  for_each = { for idx, pe in var.ai_search_private_endpoints : idx => pe }

  name                = "${var.ai_search_service_name}-pe-${each.key}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = each.value.subnet_id

  private_service_connection {
    name                           = "${var.ai_search_service_name}-ai-search-service-${each.key}"
    private_connection_resource_id = azurerm_search_service.main.id
    subresource_names              = ["searchService"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group-${each.key}"
    private_dns_zone_ids = each.value.private_dns_zone_ids
  }
  tags = var.tags
}

# resource "azurerm_search_shared_private_link_service" "openai" {
#   name               = "shared-openai"
#   search_service_id  = azurerm_search_service.main.id
#   subresource_name   = "openai_account"
#   target_resource_id = azurerm_ai_services.AIServices.id
#   request_message    = "please approve"
# }

resource "azurerm_role_assignment" "search_storage_reader" {
  scope                = var.storage_account_id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = azurerm_search_service.main.identity[0].principal_id
}

resource "azurerm_role_assignment" "search_cognitive_openai_user" {
  scope                = azurerm_ai_services.AIServices.id
  role_definition_name = "Cognitive Services OpenAI User"
  principal_id         = azurerm_search_service.main.identity[0].principal_id
}

resource "azurerm_role_assignment" "search_index_data_reader" {
  scope                = azurerm_search_service.main.id
  role_definition_name = "Search Index Data Reader"
  principal_id         = azurerm_search_service.main.identity[0].principal_id
}

resource "azurerm_role_assignment" "search_index_data_reader_2" {
  scope                = azurerm_search_service.main.id
  role_definition_name = "Search Index Data Reader"
  principal_id         = azurerm_ai_foundry.ai_hub.identity[0].principal_id
}

resource "azurerm_role_assignment" "search_index_data_reader_3" {
  scope                = azurerm_search_service.main.id
  role_definition_name = "Search Service Contributor"
  principal_id         = azurerm_ai_foundry.ai_hub.identity[0].principal_id
}
