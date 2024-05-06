## Adapted from usethis package: https://github.com/r-lib/usethis/blob/9e64daf13ac1636187d59e6446d9526a414d8ba6/tests/testthat/helper.R

create_local_package <- function(dir = fs::file_temp(pattern = "testpkg"),
                                 env = parent.frame(),
                                 rstudio = FALSE) {
  create_local_thing(dir, env, rstudio, "package")
}

create_local_thing <- function(dir = fs::file_temp(pattern = pattern),
                               env = parent.frame(),
                               rstudio = FALSE,
                               thing = c("package", "project")) {
  thing <- match.arg(thing)
  if (fs::dir_exists(dir)) {
    ui_abort("Target {.arg dir} {.path {pth(dir)}} already exists.")
  }

  old_project <- usethis:::proj_get_() # this could be `NULL`, i.e. no active project
  old_wd <- getwd()          # not necessarily same as `old_project`

  withr::defer(
    {
      print("Deleting temporary project: {.path {dir}}")
      fs::dir_delete(dir)
    },
    envir = env
  )

  switch(
      thing,
      package = usethis::create_package(
        dir,
        # This is for the sake of interactive development of snapshot tests.
        # When the active usethis project is a package created with this
        # function, testthat learns its edition from *that* package, not from
        # usethis. So, by default, opt in to testthat 3e in these ephemeral test
        # packages.
        fields = list("Config/testthat/edition" = "3"),
        rstudio = rstudio,
        open = FALSE,
        check_name = FALSE
      ),
      project = create_project(dir, rstudio = rstudio, open = FALSE)
    )

  withr::defer(usethis::proj_set(old_project, force = TRUE), envir = env)
  usethis::proj_set(dir)

  withr::defer(
    {
      print("Restoring original working directory: {.path {old_wd}}")
      setwd(old_wd)
    },
    envir = env
  )
  setwd(usethis::proj_get())

  invisible(usethis::proj_get())
}
