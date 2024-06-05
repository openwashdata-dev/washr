
#' Update the default DESCRIPTION to adhere to openwashdata style
#'
#' @description
#' This function updates the DESCRIPTION file of an R package to comply with openwashdata standards.
#' It adds or modifies fields such as doculicense, language, date, URL, etc.
#'
#' @param file File path to an R package containing DESCRIPTION. Defaults to the current working package.
#' @param github_user URL path to the GitHub user or organization that hosts the current package. Defaults to https://github.com/openwashdata.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' update_description()
#' }
#'
update_description <- function(file = ".", github_user = "https://github.com/openwashdata/"){
  pkgname <- desc::desc_get("Package", file = file)[[1]]
  # author

  # license
  usethis::use_ccby_license()

  # language
  desc::desc_set("Language", "en-GB", file = file)
  # depends

  # Other Fields
  desc::desc_set("LazyData", "true", file = file)
  desc::desc_set("Config/Needs/website", "rmarkdown", file = file)

  # Date
  desc::desc_set("Date",
                 Sys.Date(),
                 file = file)
  # URL
  desc::desc_set_urls(urls = c(paste0(github_user, pkgname)),
                      file = file)
  # Bug Reports
  desc::desc_set("BugReports",
                 paste0(github_user, pkgname, "/issues"),
                 file = file)
}
