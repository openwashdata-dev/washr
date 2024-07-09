library(httr)

community_name <- "openwashdata"
community_page <- httr::content(httr::GET(sprintf("https://zenodo.org/api/communities/%s", community_name)))
records_url <- community_page$links$records
records_url_content <- httr::content(httr::GET(records_url))
records_list <- records_url_content$hits$hits
for each record in records_list
record_stats <- record$stats
# unique view numbers
# unique downloads numbers
