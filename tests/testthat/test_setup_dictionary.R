options(usethis.quiet = TRUE)
# TEST setup_dictionary --------------------------------------------------------
test_that("setup_dictionary throws error when not in correct working directory", {
  # Mocking the current working directory without DESCRIPTION and NAMESPACE
  old_wd <- getwd()
  on.exit(setwd(old_wd))
  tempdir <- tempdir()
  setwd(tempdir)
  expect_error(setup_dictionary(), "You are not in the correct working directory")
})

test_that("setup_dictionary throws error when data-raw directory does not exist", {
  # Mocking the current working directory with DESCRIPTION file but without data-raw directory
  create_local_package()
  rlang::local_interactive(FALSE)
  expect_error(setup_dictionary())
})

test_that("setup_dictionary throws error when tidy data does not exist", {
  # Mocking the current working directory with DESCRIPTION file but without data-raw directory
  create_local_package()
  rlang::local_interactive(FALSE)
  washr::setup_rawdata()
  expect_error(setup_dictionary())
})

test_that("setup_dictionary throws no error", {
  # Mocking the current working directory with DESCRIPTION file but without data-raw directory
  create_local_package()
  rlang::local_interactive(FALSE)
  washr::setup_rawdata()
  mockdata <- data.frame(id = 1:3, name = c("A", "B", "C"))
  usethis::use_data(mockdata)
  expect_no_error(setup_dictionary())
})

test_that("setup_dictionary sets up a dictionary with correct values", {
  create_local_package()
  rlang::local_interactive(FALSE)
  washr::setup_rawdata()
  mockdata <- data.frame(id = 1:3, name = c("A", "B", "C"))
  usethis::use_data(mockdata)
  washr::setup_dictionary()
  expect_true(file.exists(file.path("data-raw", "dictionary.csv")))
  dict <- read.csv(file.path("data-raw", "dictionary.csv"))
  expect_equal(dict$file_name[1], "mockdata.rda")
  expect_equal(dict$variable_name[1], "id")
  expect_equal(dict$variable_type[1], "integer")
  expect_equal(dict$variable_name[2], "name")
  expect_equal(dict$variable_type[2], "character")
})

#TEST fill_dictionary ----------------------------------------------------------
test_that("setup_dictionary throws error when not in correct working directory", {
  create_local_package()
  rlang::local_interactive(FALSE)
  expect_error(fill_dictionary(dict_path = "dict.csv"))
})

