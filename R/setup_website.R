#' Set up a pkgdown website for the data package
#'
#' @return
#'
#'
#' @examples
#' \dontrun{
#'
#' }
#'
setup_website <- function(has_example=FALSE){
  # Check on README file
  if (is_readme_available()) {
    # Add configuration file from washr templates
    name <- desc::desc_get("Package", file = file)[[1]]
    usethis::use_template(template = "_pkgdown.yml",
                          save_as = r_path,
                          data = list(name = name),
                          ignore = FALSE,
                          open = FALSE,
                          package = "washr")
    usethis::use_pkgdown()
    pkgdown::build_site()

    # Create example vignettes
    if (has_example) {
      usethis::use_article("examples")
      devtools::build_rmd("vignettes/articles/examples.Rmd")
    }
  } else {
    usethis::ui_stop("No README.md exists. Consider to set up and write README first. You may use washr::setup_readme()")
  }
}

is_readme_available <- function(){
  return FALSE
}
