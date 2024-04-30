setup_readme <- function(has_example = TRUE){
  # Create README RMarkdown with a template
  usethis::use_readme_rmd(open = FALSE)
  readmermd_path <- fs::path(getwd(), "README", ext = "Rmd")
  pkgname <- desc::desc_get("Package")
  dataname <- list.files("data")[1]
  usethis::use_template(template = "README.rmd",
                        save_as = readme_path,
                        data = list(packagename = pkgname,
                                    dataname = dataname),
                        open = rlang::is_interactive(),
                        package = "washr")
  # Create example vignettes
  if (has_example) {
    usethis::use_article("examples")
    devtools::build_rmd("vignettes/articles/examples.Rmd")
  }

}
