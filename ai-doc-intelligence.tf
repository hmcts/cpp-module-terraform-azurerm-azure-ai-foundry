#add doc intelligence code

#add all the api keys into keyvault

resource "azurerm_cognitive_account" "formRecognizerAccount" {
  name                               = var.document_intelligence_name
  location                           = var.location
  resource_group_name                = var.resource_group_name
  kind                               = "FormRecognizer"
  sku_name                           = var.document_intelligence_sku
  custom_subdomain_name              = var.document_intelligence_name
  public_network_access_enabled      = var.document_intelligence_public_network_access_enabled
  outbound_network_access_restricted = var.outbound_network_access_restricted
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

resource "azurerm_key_vault_secret" "docIntelligenceKey" {
  name         = "AZURE-FORM-RECOGNIZER-KEY"
  value        = azurerm_cognitive_account.formRecognizerAccount.primary_access_key
  key_vault_id = var.key_vault_id
}

resource "azurerm_private_endpoint" "ai_document_intelligence_pe" {
  for_each = { for idx, pe in var.document_intelligence_private_endpoints : idx => pe }

  name                = "${var.document_intelligence_name}-pe-${each.key}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = each.value.subnet_id

  private_service_connection {
    name                           = "${var.document_intelligence_name}-doc-intelligence-${each.key}"
    private_connection_resource_id = azurerm_cognitive_account.formRecognizerAccount.id
    subresource_names              = ["account"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group-${each.key}"
    private_dns_zone_ids = each.value.private_dns_zone_ids
  }
  tags = var.tags
}
