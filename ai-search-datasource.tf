#see how to add rbac authentication instead of api key -- search service contributor role
provider "restapi" {
  uri                  = "https://${azurerm_search_service.main.name}.search.windows.net"
  write_returns_object = true
  debug                = true

  headers = {
    "api-key"      = azurerm_search_service.main.primary_key,
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


