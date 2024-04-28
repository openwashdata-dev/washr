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
#'

generate_roxygen_docs <- function(input_file_path, output_file_path, df_name = NULL) {
  # Read input CSV file
  dict <- read.csv(input_file_path)
  # Check if df_name is provided and not NULL, then filter input_df
  if (!is.null(df_name)) {
    library(dplyr)
    dict <- dplyr::filter(dict, file_name == paste0(df_name, ".rda"))
    # Update output_file_path to have the same name as df_name with .R extension
    output_file_path <- paste0("R/", df_name, ".R")
  }

  # Initialize output character vector
  output <- character()
  # Create title and description
  output <- c(output, paste0("#' ", df_name, ": Title goes here"),
              "#' ",
              "#' Description of the data goes here...")

  # Create format line
  n_rows <- NA
  n_vars <- NA
  output <- c(output, paste0("#' @format A tibble with ", n_rows,"rows and ", n_vars," variables"))
  # Create \describe block
  output <- c(output, paste0("#' ", "\\describe{"))

  # Iterate over input rows and create \item blocks
  for (i in seq_len(nrow(dict))) {
    variable_name <- dict[i, "variable_name"]
    description <- dict[i, "description"]

    # Create \item block
    item <- paste0("#'   ", "\\item{", variable_name, "}{", description, "}")

    # Append to output
    output <- c(output, item)
  }

  # Close \describe block
  output <- c(output, "#' }")

  # Label dataset
  output <-c(output, paste0('"', df_name, '"'))

  # Write output to file
  writeLines(output, output_file_path)
}
