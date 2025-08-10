

resource "restapi_object" "ai_search_indexers" {
  path         = "/indexers"
  query_string = "api-version=2025-05-01-preview"
  data = var.indexers_json
  id_attribute = "name" # The ID field on the response
  depends_on = [
    azurerm_search_service.main, restapi_object.ai_search_indexes, restapi_object.ai_search_skillsets, azurerm_role_assignment.search_storage_reader
  ]
}
