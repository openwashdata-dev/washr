#' Generate the README Rmarkdown file
#'
#' @description
#' `setup_readme()` uses the openwashdata README template to generate README files based on datasets
#' retrieved from the `data/` directory. It helps in creating consistent and informative README documentation
#' for your data packages.
#'
#' @returns NULL. This function creates a README.Rmd under the package directory.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # Generate the README file after setting up the dictionary
#' setup_dictionary()
#' # Complete and save the dictionary CSV file with variable descriptions
#' setup_readme()
#' }
setup_readme <- function(){
  # Get metadata
  readmermd_path <- fs::path("README", ext = "Rmd")
  pkgname <- desc::desc_get("Package")
  dataname <- fs::path_ext_remove(list.files("data")[1])
  if (is.na(dataname)) {
    warning("No tidy data found. Please revise the section DATA in README!")
  }
  # Create README RMarkdown with a template
  ## We need to assume tidy data, dictionary files exist to run build_readme
  ## TODO: sanity_check() on extdata?
  usethis::use_readme_rmd(open = FALSE)
  fs::file_delete(readmermd_path)
  usethis::use_template(template = "README.Rmd",
                        save_as = readmermd_path,
                        data = list(packagename = pkgname,
                                    dataname = dataname),
                        open = rlang::is_interactive(),
                        package = "washr")
  usethis::ui_todo("Finish the writing of README and run devtools::build_readme() in console.")
}

