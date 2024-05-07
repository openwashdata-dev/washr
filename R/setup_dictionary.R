#' Set up and fill in the dictionary file based on tidy data information
#'
#' @description
#' The function creates and fills in a dictionary csvfile for tidy datasets in
#' data/ directory. The dictionary csvfile contains 5 variables: directory,
#' file_name, var_name, var_type, and description. If tidy data exists, the dictionary
#' is filled with the directory information, (data) file names, variable names,
#' and variable types; otherwise, it only creates a dictionary csvfile with empty columns.
#'
#' @param dict_dir Path to the dictionary directory. Defaults to data-raw/
#' @param dict_name File name of the dictionary. Defaults to dictionary.csv
#' @param data_dir Path to the directory of the tidy R data objects. Defaults to data/
#'
#' @export
#'
#' @examples
#' \dontrun{
#' setup_rawdata()
#' # Go to data_processing.R, clean the raw data and export tidy data
#' setup_dictionary()
#' }
#'
setup_dictionary <- function(dict_dir = "data-raw", dict_name = "dictionary", data_dir = "data") {
  # Check dictionary exists
  dict_path <- fs::path(dict_dir, dict_name, ext = "csv")
  if(!file.exists(dict_path)){
    # Create empty dictionary csvfile
    create_empty_dict(dict_path)
  } else {
    # Warn if the user wants to override the dictionary if more than one row
    stop(paste("The file", dict_path, "already exists."))
  }
  # Check tidy dataset exists
  if(dir.exists(data_dir)){
    # Collect tidy data information
    tidydata_info <- collect_tidydata_info(data_dir)
    # Fill in dictionary
    dictionary <- tibble::tibble(directory = "data/",
                   file_name = tidydata_info$file_name,
                   variable_name = tidydata_info$var_name,
                   variable_type = tidydata_info$var_type,
                   description = NULL)
    # Export dictionary
    readr::write_csv(x = dictionary, file = dict_path)
    # Prompt to complete variable description
    usethis::ui_todo("Complete the dictionary with variable descriptions.")
  } else {
    # Error because tidy data is not yet available, should complete that first
    naerror <- simpleError("There is no tidy data available. Try with devtools::use_data() to store the tidy data as an R data object.")
    stop(naerror)
  }
}

create_empty_dict <- function(dict_path){
  file.create(dict_path)
  writeLines(text = "directory,file_name,variable_name,variable_type,description",
             con = dict_path)
}

collect_tidydata_info <- function(data_dir){
  tidy_data_names <- list.files(data_dir)
  file_name <- c()
  var_name <- c()
  var_type <- c()
  for (d in tidy_data_names){
    tidydata <- load_object(fs::path(data_dir, d)) # Read in tidy dataset(s)
    file_name <- c(file_name, rep(d, ncol(tidydata)))
    var_name <-c(var_name, colnames(tidydata))
    var_type <- c(var_type, sapply(tidydata, typeof))
  }
  return(data.frame(file_name, var_name, var_type))
}

load_object <- function(file) {
  tmp_env <- new.env()
  load(file = file, envir = tmp_env)
  head(tmp_env[[ls(tmp_env)[1]]])
}
