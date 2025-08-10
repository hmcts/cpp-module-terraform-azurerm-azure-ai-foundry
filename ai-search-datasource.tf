#see how to add rbac authentication instead of api key -- search service contributor role
data "azurerm_search_service" "search" {
  count               = var.lookup_search_service ? 1 : 0
  name                = var.ai_search_service_name
  resource_group_name = var.resource_group_name
  depends_on          = [azurerm_search_service.main]
}
#delete the restapis with aisearch deletion
provider "restapi" {
  uri                  = "https://${azurerm_search_service.main.name}.search.windows.net"
  write_returns_object = true
  debug                = true

  headers = {
    "api-key"      = var.lookup_search_service ? data.azurerm_search_service.search[0].primary_key : "",
    "Content-Type" = "application/json"
  }
}


resource "restapi_object" "storage_account_datasource" {
  path         = "/datasources"
  query_string = "api-version=2023-10-01-Preview"

  data = var.datasource_json

  id_attribute = "name"

  depends_on = [
    azurerm_search_service.main
  ]
}

