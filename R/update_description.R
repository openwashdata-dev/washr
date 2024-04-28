
#' Update the default DESCRIPTION to openwashdata DESCRIPTION style
#'
#' @description
#' Update the DESCRIPTION with doculicense CC BY.
#' Add new fields such as language, date, url and etc.
#'
#' @param file File path to an R package containing DESCRIPTION, default to the current working package.
#' @param github_user URL path to the GitHub user or organization that hosts the current package, default to https://github.com/openwashdata.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' update_description()
#' }
update_description <- function(file = ".", github_user = "https://github.com/openwashdata/"){
  pkgname <- desc::desc_get("Package", file = file)[[1]]
  # author

  # license
  # usethis::use_ccby_license()
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
