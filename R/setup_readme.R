#' Title
#'
#' @param has_example
#'
#' @return
#' @export
#'
#' @examples
setup_readme <- function(has_example = FALSE){
  # Get metadata
  readmermd_path <- fs::path("README", ext = "Rmd")
  pkgname <- desc::desc_get("Package")
  dataname <- list.files("data")[1]
  if (is.na(dataname)) {
    warning("No tidy data found. Please revise the section DATA in README!")
  }
  # Create README RMarkdown with a template
  ## We need to assume tidy data, dictionary files exist to run build_readme
  usethis::use_readme_rmd(open = FALSE)
  fs::file_delete(readmermd_path)
  usethis::use_template(template = "README.rmd",
                        save_as = readmermd_path,
                        data = list(packagename = pkgname,
                                    dataname = dataname),
                        open = FALSE,
                        package = "washr")
  # Create example vignettes
  if (has_example) {
    usethis::use_article("examples")
    devtools::build_rmd("vignettes/articles/examples.Rmd")
  }
}
