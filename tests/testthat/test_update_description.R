options(usethis.quiet = TRUE)
test_that("DESCRIPTION file is updated", {
  create_local_package()
  rlang::local_interactive(FALSE)
  washr::update_description()
  expect_true(file.exists("DESCRIPTION"))
})
