options(usethis.quiet = TRUE)
# TEST setup_readme ------------------------------------------------------------
test_that("setup_readme throws a warning when no tidy dataset available in data/", {
  create_local_package()
  rlang::local_interactive(FALSE)
  expect_warning(setup_readme())
})

test_that("setup_readme runs when there is data objects", {
  create_local_package()
  rlang::local_interactive(FALSE)
  d1 <- tibble::tibble(id = 1:3, name = c("A", "B", "C"))
  usethis::use_data(d1)
  expect_no_error(setup_readme())
})
