


resource "restapi_object" "ai_search_skillsets" {
  path         = "/skillsets"
  query_string = "api-version=2025-05-01-preview"
  data = templatefile("${path.module}/templates/config/skillsets_template.json", {
        skillsets_name   = var.skillsets_name
        ai_services_name   = var.ai_services_name
        deploymentId = var.deploymentId
        modelName     = var.modelName
        indexes_name = var.indexes_name
      })
  id_attribute = "name" # The ID field on the response
  depends_on = [
    azurerm_search_service.main, restapi_object.ai_search_indexes
  ]
}
