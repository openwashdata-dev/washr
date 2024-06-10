options(usethis.quiet = TRUE)
# TEST setup_website -----------------------------------------------------------
test_that("setup_website throws an error when no README file available", {
  create_local_package()
  rlang::local_interactive(FALSE)
  expect_error(setup_website())
})
