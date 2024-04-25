## code to prepare `{{{name}}}` dataset goes here
library(usethis)
library(fs)
library(here)
library(readr)
library(openxlsx)


## Export Data -----------------------------------------------------------------
usethis::use_data({{{name}}}, overwrite = TRUE)
fs::dir_create(here::here("inst", "extdata"))
readr::write_csv({{{name}}},
                 here::here("inst", "extdata", paste0({{{name}}}, ".csv")))
openxlsx::write.xlsx({{{name}}},
                     here::here("inst", "extdata", paste0({{{name}}}, ".xlsx")))
