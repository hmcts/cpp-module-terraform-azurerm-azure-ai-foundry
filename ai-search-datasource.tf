#see how to add rbac authentication instead of api key -- search service contributor role
# data "azurerm_search_service" "search" {
#   name                = "ai-idpc-search-service"
#   resource_group_name = "RG-STE-AI-IDPC-01"
# }
provider "restapi" {
  uri                  = "https://${azurerm_search_service.main.name}.search.windows.net"
  write_returns_object = true
  debug                = true

  headers = {
    "api-key"      = azurerm_search_service.main.primary_key,
    "Content-Type" = "application/json"
  }
}


resource "restapi_object" "storage_account_datasource" {
  path         = "/datasources"
  query_string = "api-version=2023-10-01-Preview"

  data = templatefile("${path.module}/templates/config/datasource_template.json", {
    datasource_name   = var.datasource_name
    datasource_type   = var.datasource_type
    storage_account_id = var.storage_account_id
    container_name     = var.container_name
  })

  id_attribute = "name"

  depends_on = [
    azurerm_search_service.main
  ]
}

