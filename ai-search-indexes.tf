# data "azurerm_search_service" "search" {
#   count               = var.lookup_search_service ? 1 : 0
#   name                = var.ai_search_service_name
#   resource_group_name = var.resource_group_name
#   depends_on          = [azurerm_search_service.main]
# }
#delete the restapis with aisearch deletion
data "http" "ai_search_index_json" {
  url = "https://raw.githubusercontent.com/hmcts/cp-ai-rag-service/refs/tags/v17.0.17/ai-document-shared-artefacts/src/main/resources/vector-db-index-schema.json"
}

provider "restapi" {
  uri                  = "https://${azurerm_search_service.main.name}.search.windows.net"
  write_returns_object = true
  debug                = true

  headers = {
    "api-key"      = azurerm_search_service.main.primary_key,
    "Content-Type" = "application/json"
  }
}

resource "restapi_object" "ai_search_indexes" {
  path         = "/indexes"
  query_string = "api-version=2025-05-01-preview"
  data         = data.http.ai_search_index_json.response_body
  id_attribute = "name" # The ID field on the response
  depends_on = [
    azurerm_search_service.main, azurerm_private_endpoint.ai_search_pe
  ]
}