#azure ai hub
resource "azurerm_ai_foundry" "ai_hub" {
  name                    = var.ai_hub
  location                = var.location
  resource_group_name     = var.resource_group_name
  application_insights_id = var.application_insights_id
  key_vault_id            = var.key_vault_id
  storage_account_id      = var.ai_hub_storage_account_id
  public_network_access   = var.public_network_access

  dynamic "identity" {
    for_each = var.identity == {} ? [] : [var.identity]
    content {
      type         = lookup(identity.value, "type", null)
      identity_ids = lookup(identity.value, "identity_ids", null)
    }
  }

  dynamic "encryption" {
    for_each = var.enable_encryption ? [1] : []
    content {
      key_vault_id = var.encryption_key_vault_id
      key_id       = var.encryption_key_id
    }
  }
  dynamic "managed_network" {
    for_each = var.enable_managed_network ? [1] : []
    content {
      isolation_mode = var.managed_network_isolation_mode
    }
  }
  tags = var.tags
}




resource "azurerm_private_endpoint" "ws_pe" {
  for_each            = { for idx, pe in var.ai_hub_private_endpoints : idx => pe }
  name                = "${var.ai_hub}-pe-${each.key}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = each.value.subnet_id

  private_service_connection {
    name                           = "${var.ai_hub}-ws-psc-${each.key}"
    private_connection_resource_id = azurerm_ai_foundry.ai_hub.id
    subresource_names              = ["amlworkspace"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group-${each.key}"
    private_dns_zone_ids = each.value.private_dns_zone_ids
  }
  tags = var.tags
}

#azure ai hub project

resource "azurerm_ai_foundry_project" "this" {
  name     = var.project_name
  location = var.location

  dynamic "identity" {
    for_each = var.identity == {} ? [] : [var.identity]
    content {
      type         = lookup(identity.value, "type", null)
      identity_ids = lookup(identity.value, "identity_ids", null)
    }
  }

  description        = var.project_description
  friendly_name      = var.project_name
  ai_services_hub_id = azurerm_ai_foundry.ai_hub.id

  tags = var.tags
  depends_on = [
    azurerm_ai_foundry.ai_hub
  ]

}
