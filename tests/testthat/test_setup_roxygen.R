options(usethis.quiet = TRUE)
# TEST setup_roxygen --------------------------------------------------------
test_that("setup_roxygen throws error when no tidy dataset available in data/", {
  create_local_package()
  rlang::local_interactive(FALSE)
  washr::setup_rawdata()
  file.create("data-raw/dictionary.csv")
  expect_error(setup_roxygen())
})

test_that("setup_roxygen throws error when no dictionary data/", {
  create_local_package()
  rlang::local_interactive(FALSE)
  washr::setup_rawdata()
  d1 <- data.frame(id = 1:3, name = c("A", "B", "C"))
  usethis::use_data(d1)
  expect_error(setup_roxygen())
})

test_that("setup_roxygen throws error when no dictionary data/", {
  create_local_package()
  rlang::local_interactive(FALSE)
  washr::setup_rawdata()
  d1 <- data.frame(id = 1:3, name = c("A", "B", "C"))
  usethis::use_data(d1)
  washr::setup_dictionary()
  washr::setup_roxygen()
  expect_true(file.exists(file.path(getwd(), "R", "d1.R")))
})
