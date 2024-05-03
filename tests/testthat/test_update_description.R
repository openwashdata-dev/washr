options(usethis.quiet = TRUE)
test_that("DESCRIPTION file is updated", {
  washr::update_description()
  expect_true(file.exists("DESCRIPTION"))
  expect_equal(file.size("DESCRIPTION"), 835)
})
