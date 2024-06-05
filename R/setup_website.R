#' Set up a pkgdown website for the data package
#'
#' @param has_example Should the pkgdown website include an example vignette page?
#'
#' @return NULL
#' @export
#'
#' @examples
#' \dontrun{
#'  setup_website(has_example = TRUE)
#' }
setup_website <- function(has_example=FALSE){
  # Check on README file
  if (is_readme_available()) {
    # Add configuration file from washr templates
    name <- desc::desc_get("Package")[[1]]
    usethis::use_template(template = "_pkgdown.yml",
                          save_as = "./_pkgdown.yml",
                          data = list(name = name),
                          ignore = FALSE,
                          open = FALSE,
                          package = "washr")
    usethis::use_pkgdown()

    # Create example vignettes
    if (has_example) {
      usethis::use_article("examples")
      devtools::build_rmd("vignettes/articles/examples.Rmd")
    }
    pkgdown::build_site()
  } else {
    usethis::ui_stop("No README.md exists. Consider to set up and write README first. You may use washr::setup_readme()")
  }
}

is_readme_available <- function(){
  is_available <- fs::file_exists(fs::path_wd("README.md"))
  return(is_available)
}
