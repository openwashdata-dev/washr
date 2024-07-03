release_package <- function(owner = "openwashdata"){
  # Release to GitHub
  pkgname <-
  repo <- sprintf("/users/%s/%s/releases", owner, pkgname)

  version <- desc::desc_get("Version")
  tag <- paste0("v", version)
  release_name <- paste(pkgname, tag, ":", desc::desc_get("Title"))
  release_query <- paste("POST", repo)
  gh::gh(release_query,
         tag_name = tag,
         name = release_name) #refer to: https://docs.github.com/en/rest/releases/releases?apiVersion=2022-11-28
  # append to owd gsheet
  googlesheets4::sheet_append()
  # post an issue to website repo
  # gh::gh("POST /repos/openwashdata/website/issues")
  # post an issue to newsletter
  # gh::gh("POST /repos/openwashdata-dev/newsletter/issues/1")
}
