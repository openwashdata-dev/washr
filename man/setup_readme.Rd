% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/setup_readme.R
\name{setup_readme}
\alias{setup_readme}
\title{Generate the README Rmarkdown file}
\usage{
setup_readme()
}
\value{
NULL. This function creates a README.Rmd under the package directory.
}
\description{
\code{setup_readme()} uses the openwashdata README template to generate README files based on datasets
retrieved from the \verb{data/} directory. It helps in creating consistent and informative README documentation
for your data packages.
}
\examples{
\dontrun{
# Generate the README file after setting up the dictionary
setup_dictionary()
# Complete and save the dictionary CSV file with variable descriptions
setup_readme()
}
}
