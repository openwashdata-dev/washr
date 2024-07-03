add_zenodo_metadata <- function(){
  pkgname <- "pkgname"

  related_identifier_list = list(
    identifier = sprintf("https://openwashdata.github.io/%s/", pkgname),
    relation = "isCompiledBy",
    resource_type = "dataset"
  )

  metadata = list(
    upload_type = "dataset",
    notes = sprintf("Visit the website of this dataset for instructions how to use it:
    https://openwashdata.github.io/%s/", pkgname),
    related_identifiers = related_identifier_list,
    communities = list(identifier = "openwashdata")
  )

  metadata_json <- jsonlite::toJSON(metadata, pretty=TRUE,auto_unbox = TRUE)
  return(metadata_json)
  }
