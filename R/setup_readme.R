setup_readme <- function(name = "README", has_example = FALSE){
  readmermd_path <- fs::path(name, ext = "Rmd")
  pkgname <- desc::desc_get("Package")
  dataname <- list.files("data")[1]
  if (is.na(dataname)) {
    warning("No tidy data found. Please revise the section DATA in README!")
  }
  # Create README RMarkdown with a template
  usethis::use_readme_rmd(open = FALSE)
  usethis::use_template(template = "README.rmd",
                        save_as = readmermd_path,
                        data = list(packagename = pkgname,
                                    dataname = dataname),
                        open = FALSE,
                        package = "washr")

  # devtools::build_readme()
  # Create example vignettes
  if (has_example) {
    usethis::use_article("examples")
    devtools::build_rmd("vignettes/articles/examples.Rmd")
  }
}
