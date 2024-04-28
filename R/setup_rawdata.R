
#' Create the data-raw directory with a data-processing.R template
#'
#' @description
#' `setup_rawdata()` creates a directory for raw data and an example script
#' `data_processing.R` for exporting the processed data. It will ask to override
#' an empty `data_processing.R` generated when first creating the directory,
#' please choose to override it for openwashdata dataset package development.
#' The templates assumes the dataset name is the same with the data package name.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' setup_rawdata()
#' }
#'
setup_rawdata <- function(){
  usethis::use_data_raw(name = "data_processing", open = FALSE)
  r_path <- fs::path("data-raw", "data_processing", ext = "R")
  name <- basename(getwd())
  usethis::use_template(
    "data_processing.R",
    save_as = r_path,
    data = list(name = name),
    ignore = FALSE,
    open = rlang::is_interactive(),
    package = "washr"
  )
  # Post a github issue to upload raw data
  # gh::gh(
  #   endpoint = paste0("POST openwashdata/", name, "/issues/"),
  #   title = "Add raw data for data-raw folder",
  #   body = "TODO"
  # )

  # Create empty dictionary file
  dict_path <- fs::path("data-raw", "dictionary", ext = "csv")
  file.create(dict_path)
  writeLines(text = "directory,file_name,variable_name,variable_type,description",
             con = dict_path)
}
