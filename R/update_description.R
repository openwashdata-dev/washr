update_description <- function(){
  # author
  # license
  usethis::use_ccby_license()
  # language

  # depends

  #
  # LazyData: true
  # Config/Needs/website: rmarkdown

  # Date
  desc::desc_set(key = "Date",
                 list_value = Sys.Date())
  # URL
  pkgname <- desc::desc_get("Package")[[1]]
  desc::desc_set_urls(urls = c(paste0("https://github.com/openwashdata/", pkgname)))
  # Bug Reports
  desc::desc_set(key = "BugReports",
                 list_value = "https://github.com/openwashdata/washopenresearch/issues")
}
