resource "azapi_resource" "rai_policy_disable_all" {
  type      = "Microsoft.CognitiveServices/accounts/raiPolicies@2024-10-01"
  name      = "${var.rai_policy_name}"
  parent_id = azurerm_ai_services.AIServices.id

  body = {
    properties = {
      basePolicyName = "Microsoft.Default"
      mode           = "Asynchronous_filter"

      contentFilters = [
        # --- Disable all harm categories completely ---
        {
          name              = "Hate"
          blocking          = false
          enabled           = false
          severityThreshold = "High"
          source            = "Prompt"
        },
        {
          name              = "Hate"
          blocking          = false
          enabled           = false
          severityThreshold = "High"
          source            = "Completion"
        },
        {
          name              = "Sexual"
          blocking          = false
          enabled           = false
          severityThreshold = "High"
          source            = "Prompt"
        },
        {
          name              = "Sexual"
          blocking          = false
          enabled           = false
          severityThreshold = "High"
          source            = "Completion"
        },
        {
          name              = "Selfharm"
          blocking          = false
          enabled           = false
          severityThreshold = "High"
          source            = "Prompt"
        },
        {
          name              = "Selfharm"
          blocking          = false
          enabled           = false
          severityThreshold = "High"
          source            = "Completion"
        },
        {
          name              = "Violence"
          blocking          = false
          enabled           = false
          severityThreshold = "High"
          source            = "Prompt"
        },
        {
          name              = "Violence"
          blocking          = false
          enabled           = false
          severityThreshold = "High"
          source            = "Completion"
        },

        # --- Disable prompt shields and additional filters ---
        {
          name     = "Jailbreak"
          blocking = false
          enabled  = false
          source   = "Prompt"
        },
        {
          name     = "Protected Material Text"
          blocking = false
          enabled  = false
          source   = "Completion"
        },
        {
          name     = "Protected Material Code"
          blocking = false
          enabled  = false
          source   = "Completion"
        },
        {
          name     = "Profanity"
          blocking = false
          enabled  = false
          source   = "Prompt"
        }
      ]
    }
  }

  response_export_values = ["*"]
}



resource "azurerm_cognitive_deployment" "models" {
  for_each             = var.model_deployments
  name                 = each.key
  cognitive_account_id = azurerm_ai_services.AIServices.id

  model {
    format  = each.value.format
    name    = each.value.model_name
    version = each.value.version
  }

  sku {
    name     = each.value.sku_name
    capacity = each.value.capacity
  }

  rai_policy_name            = each.value.rai_policy_name
  version_upgrade_option     = each.value.version_upgrade_option
  dynamic_throttling_enabled = each.value.dynamic_throttling_enabled

  depends_on = [azapi_resource.rai_policy_disable_all]
}
