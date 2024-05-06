options(usethis.quiet = TRUE)
test_that("File and directory are created", {
  create_local_package()

  rlang::local_interactive(FALSE)
  print(getwd())
  washr::setup_rawdata()
  expect_true(file.exists("data-raw/data_processing.R"))
  expect_equal(file.size("data-raw/data_processing.R"), 1102)
})
unlink("data-raw", recursive = TRUE)
