#' Generate a citation file for the dataset.
#'
#' @param doi DOI(Digital Object Identifier)
#'
#' @return NULL
#' @export
#'
#' @examples
#' \dontrun{
#'   add_citation(doi = "10.5281/zenodo.11185699")
#' }
add_citation <- function(doi){
  # creates CFF with all author roles
  mod_cff <- cffr::cff_create("DESCRIPTION",
                        dependencies = FALSE,
                        keys = list("doi" = doi,
                                    "date-released" = desc::desc_get("Date")))

  # Remove the preferred-citation key
  mod_cff$`preferred-citation` <- NULL

  # writes the CFF file
  cffr::cff_write(mod_cff)

  # Now write a CITATION file from the CITATION.cff file
  # Use inst/CITATION instead (the default if not provided)
  path_cit <- file.path("inst/CITATION")

  a_cff <- cffr::cff_read(path = "CITATION.cff")

  cffr::cff_write_citation(a_cff, file = path_cit)

  # By last, read the citation
  cat(readLines(path_cit), sep = "\n")
}
