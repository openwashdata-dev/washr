
#' Update the DESCRIPTION file to conform with openwashdata standards
#'
#' @description
#' This function updates the DESCRIPTION file of an R package to comply with openwashdata standards.
#' It ensures that fields such as `License`, `Language`, `Date`, `URL`, and others are correctly specified.
#'
#' @param file Character. The file path to the DESCRIPTION file of the R package. Defaults to the current working directory.
#' @param github_user Character. The URL path to the GitHub user or organization that hosts the current package. Defaults to "https://github.com/openwashdata".
#'
#' @export
#'
#' @returns NULL. Update fields directly in DESCRIPTION file.
#' @examples
#' \dontrun{
#' # Update DESCRIPTION file in the current package
#' update_description()
#'
#' # Update DESCRIPTION file in a specific package
#' update_description(file = "path/to/your/package/DESCRIPTION")
#'
#' # Update DESCRIPTION file with a specific GitHub user
#' update_description(github_user = "https://github.com/yourusername")
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
