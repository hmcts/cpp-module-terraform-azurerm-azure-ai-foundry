locals {
  skillsets_json = {
    "name" : "idpcskillset",
    "description" : "IDPC skillset configuration",
    "skills" : [
      {
        "@odata.type": "#Microsoft.Skills.Text.SplitSkill",
        "name" : "#1",
        "description" : "Split skill to chunk documents",
        "context" : "/document",
        "defaultLanguageCode" : "en",
        "textSplitMode" : "pages",
        "maximumPageLength" : 2000,
        "pageOverlapLength" : 500,
        "maximumPagesToTake" : 0,
        "unit" : "characters",
        "inputs" : [
          {
            "name" : "text",
            "source" : "/document/content",
            "inputs" : []
          }
        ],
        "outputs" : [
          {
            "name" : "textItems",
            "targetName" : "pages"
          }
        ]
      },
      {
        "@odata.type": "#Microsoft.Skills.Text.AzureOpenAIEmbeddingSkill",
        "name" : "#2",
        "context" : "/document/pages/*",
        "resourceUri" : "https://${var.ai_services_name}.openai.azure.com",
        "deploymentId" : "text-embedding-3-large", #deployment model added directly
        "dimensions" : 3072,
        "modelName" : "text-embedding-3-large",
        "inputs" : [
          {
            "name" : "text",
            "source" : "/document/pages/*",
            "inputs" : []
          }
        ],
        "outputs" : [
          {
            "name" : "embedding",
            "targetName" : "text_vector"
          }
        ]
      },
      {
        "@odata.type": "#Microsoft.Skills.Util.DocumentExtractionSkill",
        "name" : "#3",
        "context" : "/document",
        "parsingMode" : "default",
        "dataToExtract" : "contentAndMetadata",
        "inputs" : [
          {
            "name" : "file_data",
            "source" : "/document/file_data",
            "inputs" : []
          }
        ],
        "outputs" : [
          {
            "name" : "content",
            "targetName" : "extracted_content"
          },
          {
            "name" : "metadata_storage_name",
            "targetName" : "file_name"
          },
          {
            "name" : "metadata_storage_last_modified",
            "targetName" : "last_modified"
          },
          {
            "name" : "idpc_id",
            "targetName" : "document_idpc_id"
          },
          {
            "name" : "metadata_author",
            "targetName" : "document_author"
          }
        ],
        "configuration" : {}
      }
    ],

    "indexProjections" : {
      "selectors" : [
        {
          "targetIndexName" : local.indexes_json.name,
          "parentKeyFieldName" : "parent_id",
          "sourceContext" : "/document/pages/*",
          "mappings" : [
            {
              "name" : "text_vector",
              "source" : "/document/pages/*/text_vector",
              "inputs" : []
            },
            {
              "name" : "chunk",
              "source" : "/document/pages/*",
              "inputs" : []
            },
            {
              "name" : "title",
              "source" : "/document/title",
              "inputs" : []
            },
            {
              "name" : "idpc_id",
              "source" : "/document/idpc_id",
              "inputs" : []
            },
            {
              "name" : "document_file_name",
              "source" : "/document/metadata_storage_name",
              "inputs" : []
            },
            {
              "name" : "document_file_url",
              "source" : "/document/metadata_storage_path",
              "inputs" : []
            }
          ]
        }
      ],
      "parameters" : {
        "projectionMode" : "skipIndexingParentDocuments"
      }
    }
  }
}



resource "restapi_object" "ai_search_skillsets" {
  path         = "/skillsets"
  query_string = "api-version=2024-07-01"
  data         = jsonencode(local.skillsets_json)
  id_attribute = "name" # The ID field on the response
  depends_on = [
    azurerm_search_service.main, restapi_object.ai_search_indexes
  ]
}
