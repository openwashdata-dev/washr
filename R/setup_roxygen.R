#' Set up roxygen documentation for all tidy data sets using the dictionary
#'
#' @description
#' `setup_roxygen()` creates Roxygen documentation for all tidy data sets found
#' in the dictionary file. The dictionary should include columns for
#' directory, file name, variable name, variable type, and description. This
#' function generates Roxygen comments with this information, facilitating
#' consistent and thorough documentation for your data sets.
#'
#' @return NULL
#' @export
#'
#' @examples
#' \dontrun{
#' setup_dictionary()
#' # Go to data-raw/dictionary.csv and complete column description.
#' setup_roxygen()
#' }
#'
setup_roxygen <- function() {
  # Check dictionary existence
  input_file_path <- fs::path_wd("data-raw", "dictionary", ext = "csv")
  if (!file.exists(input_file_path)) {
    usethis::ui_stop("Data dictionary does not exist in the data-raw/ directory. Please set up the raw data or create a dictionary first.")
  }
  # Check R/ existence
  output_file_dir <- fs::path_wd("R")
  if (!dir.exists(output_file_dir)) {
    usethis::use_r(open = FALSE)
  }
  # Check data/ existence
  tidy_datasets <- list.files(path = fs::path_wd("data"))
  num_tidy_datasets <- length(tidy_datasets)
  # Write roxygen doc for each tidy dataset
  if (num_tidy_datasets == 0){
    usethis::ui_stop("No tidy data sets are available in the data/ directory.
                     Please complete data processing and export tidy data first.")
  } else {
    for (d in tidy_datasets){
      # Update output_file_path to have the same name as df_name with .R extension
      df_name <- fs::path_ext_remove(fs::path_file(d))
      output_file_path <- fs::path(output_file_dir, df_name, ext = "R")
      generate_roxygen_docs(input_file_path = input_file_path,
                            output_file_path = output_file_path,
                            df_name = df_name)
      usethis::ui_todo("Please write the title and description for \n {usethis::ui_value(output_file_path)}")
    }
  }
}

#' Generate roxygen2 documentation from a CSV file
#'
#' This function takes a CSV table with columns `variable_name` and `description` as input,
#' optionally filters it by `variable_name`, and outputs roxygen2 documentation for `\describe` and `\item`.
#'
#' @param input_file_path Path to the input CSV file.
#' @param output_file_path Path to the output file that will contain the roxygen2 documentation.
#' @param df_name Optional name of the variable to filter the input dataframe by. Default is NULL.
#'
#' @return NULL
#'
#' @export
#'
#' @examples \dontrun{
#' # Generate roxygen2 documentation from example.csv
#' generate_roxygen_docs("example.csv", "output.R")
#' # Generate roxygen2 documentation from example.csv for a specific variable name
#' generate_roxygen_docs("example.csv", "output.R", df_name = "specific_variable")
#' }
#'
generate_roxygen_docs <- function(input_file_path, output_file_path, df_name=NULL){
  # Read input CSV file
  dict <- readr::read_csv(input_file_path)
  ## If an empty csv should quit with error: Cannot generate roxygen file with an empty dictionary
  # Check if df_name is provided and not NULL, then filter input_df
  dict <- dplyr::filter(dict, dict$file_name == paste0(df_name, ".rda"))
  if (file.exists(output_file_path)) {
    head <- get_roxygen_head(output_file_path)
  } else {
    head <- create_roxygen_head(df_name)
  }
  body <- create_roxygen_body(dict)
  output <- c(head, body)
  # Label dataset
  output <-c(output, paste0('"', df_name, '"'))
  # Write output to file
  writeLines(output, output_file_path)
}

create_roxygen_head <- function(df_name) {
  # Create title and description
  roxygen_head <- c(paste0("#' ", df_name, ": Title goes here"),
              "#' ",
              "#' Description of the data goes here...",
              "#' ")
  return(roxygen_head)
}

get_roxygen_head <- function(roxygen_file_path){
  roxygen_head <- character()
  roxygen_text <- readLines(roxygen_file_path)
  i <- 1
  line <- roxygen_text[1]
  while (!startsWith(line, prefix = "#' @format")) {
    output <- c(roxygen_head, roxygen_text[i])
    i <- i+1
    line <- roxygen_text[i]
  }
  return(roxygen_head)
}

create_roxygen_body <- function(dict){
  # Create format line
  dataobj <- fs::path("data", dict$file_name[1])
  n_rows <- nrow(load_object(dataobj)) #TODO: Load the data object
  n_vars <- nrow(dict)
  format_line <- paste0("#' @format A tibble with ", n_rows,"rows and ", n_vars," variables")

  # Create \describe block
  block <- create_describe_block(dict)
  output <- c(format_line, block)
  return(output)
}

create_describe_block <- function(dict){
  block <- character()
  block <- c(block, paste0("#' ", "\\describe{"))

  # Iterate over input rows and create \item blocks
  for (i in seq_len(nrow(dict))) {
    variable_name <- dict[i, "variable_name"]
    description <- dict[i, "description"]

    # Create \item block
    item <- paste0("#'   ", "\\item{", variable_name, "}{", description, "}")

    # Append to output
    block <- c(block, item)
  }

  # Close \describe block
  block <- c(block, "#' }")
  return(block)
}
