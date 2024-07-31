library(httr)

get_community_records <- function(name){
  community_page <- httr::content(httr::GET(sprintf("https://zenodo.org/api/communities/%s", name)))
  records_url <- community_page$links$records
  records_url_content <- httr::content(httr::GET(records_url))
  records_list <- records_url_content$hits$hits
  # add request datetime
  return(records_list)
}

get_record_by_doi <- function(doi){
  id <- strsplit(doi, "zenodo.")[[1]][2]
  record <- httr::content(httr::GET(sprintf("https://zenodo.org/api/records/%s", id)))
  # add request datetime
  return(record)
}

record_stats
# unique view numbers
record$stats$unique_views
# unique downloads numbers
record$stats$unique_downloads
