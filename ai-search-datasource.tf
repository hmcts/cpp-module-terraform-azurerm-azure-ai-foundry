#see how to add rbac authentication instead of api key -- search service contributor role
data "azurerm_search_service" "search" {
  name                = "ai-idpc-search-service"
  resource_group_name = "RG-STE-AI-IDPC-01"
}
provider "restapi" {
  uri                  = "https://${azurerm_search_service.main.name}.search.windows.net"
  write_returns_object = true
  debug                = true

  headers = {
    "api-key"      = data.azurerm_search_service.search,
    "Content-Type" = "application/json"
  }
}

locals {
  datasource_json = {
    name : "idpcdatasource",
    description : "IDPC data source configuration",
    type : "azureblob",
    credentials : {
      connectionString : "ResourceId=${var.storage_account_id};"
    },
    container : {
      name : "${var.container_name}",
    },
  }
}

resource "restapi_object" "storage_account_datasource" {
  path         = "/datasources"
  query_string = "api-version=2023-10-01-Preview"
  data         = jsonencode(local.datasource_json)
  id_attribute = "name" # The ID field on the response
  depends_on = [
    azurerm_search_service.main
  ]
}
