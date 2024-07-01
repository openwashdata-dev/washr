add_zenodo_metadata <- function(){
  related_identifier_list = list(
    identifier = "https://openwashdata.github.io/boreholefuncmwi/",
    relation = "isCompiledBy",
    resource_type = "dataset"
  )

  metadata = list(
    upload_type = "dataset",
    notes = "Visit the website of this dataset for instructions how to use it:
    https://openwashdata.github.io/boreholefuncmwi/",
    related_identifiers = related_identifier_list,
    communities = list(identifier = "openwashdata")
  )

  jsonlite::toJSON(metadata, pretty=TRUE,auto_unbox = TRUE)
}
