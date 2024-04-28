#' Set up and fill in the dictionary file based on tidy data information
#'
#' @description
#' A short description...
#'
#' @param dict_dir Path to the dictionary directory, default to data-raw/
#' @param dict_name File name of the dictionary, default to dictionary.csv
#' @param data_dir Path to the directory of the tidy R data objects, default to data/
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
setup_dictionary <- function(dict_dir = "data-raw", dict_name = "dictionary.csv", data_dir = "data") {
  # Check dictionary exists
  dict_path <- fs::path(dict_dir, dict_name)
  if(!file.exists(dict_path)){
    file.create(dict_path)
  } else {
    # Warn if the user wants to override the dictionary if more than one row
  }
  # Check tidy dataset exists
  if(dir.exists(data_dir)){
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

    # Fill in dictionary
    dictionary <- tibble::tibble(directory = "data/",
                   file_name = file_name,
                   variable_name = var_name,
                   variable_type = var_type,
                   description = NULL)
    # Export dictionary
    readr::write_csv(x = dictionary, file = dict_path)
  } else {
    # Error because tidy data is not yet available, should complete that first
    naerror <- simpleError("There is no tidy data available. Try with devtools::use_data() to store the tidy data as an R data object.")
    stop(naerror)
  }


}

load_object <- function(file) {
  tmp_env <- new.env()
  load(file = file, envir = tmp_env)
  head(tmp_env[[ls(tmp_env)[1]]])
}
