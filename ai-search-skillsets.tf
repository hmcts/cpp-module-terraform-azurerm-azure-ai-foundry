resource "restapi_object" "ai_search_skillsets" {
  path         = "/skillsets"
  query_string = "api-version=2025-05-01-preview"
  data = var.skillsets_json
  id_attribute = "name" # The ID field on the response
  depends_on = [
    azurerm_search_service.main, restapi_object.ai_search_indexes
  ]
}