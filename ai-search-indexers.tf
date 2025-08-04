locals {
  indexers_json = {
    "name" : "idpcIndexer",
    "dataSourceName" : local.datasource_json.name,
    "targetIndexName" : local.indexes_json.name,
    "skillsetName" : local.skillsets_json.name,
    "parameters" : {
      "batchSize" : null,
      "maxFailedItems" : null,
      "maxFailedItemsPerBatch" : null,
      "configuration" : {
        "dataToExtract" : "contentAndMetadata",
        "parsingMode" : "default"
      }
    },
    "fieldMappings" : [
      {
        "sourceFieldName" : "metadata_storage_name",
        "targetFieldName" : "title",
        "mappingFunction" : null
      }
    ],
  }
}


resource "restapi_object" "ai_search_indexers" {
  path         = "/indexers"
  query_string = "api-version=2025-05-01-preview"
  data         = jsonencode(local.indexers_json)
  id_attribute = "name" # The ID field on the response
  depends_on = [
    azurerm_search_service.main, restapi_object.ai_search_indexes, restapi_object.ai_search_skillsets
  ]
}
