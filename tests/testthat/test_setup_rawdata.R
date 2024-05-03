options(usethis.quiet = TRUE)
test_that("File and directory are created", {
  washr::setup_rawdata()
  expect_true(file.exists("data-raw/data_processing.R"))
  expect_equal(file.size("data-raw/data_processing.R"), 1102)
})
unlink("data-raw", recursive = TRUE)
