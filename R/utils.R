#' @importFrom utils head
load_object <- function(file) {
  tmp_env <- new.env()
  load(file = file, envir = tmp_env)
  tmp_env[[ls(tmp_env)[1]]]
}
