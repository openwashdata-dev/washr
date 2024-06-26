% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/update_description.R
\name{update_description}
\alias{update_description}
\title{Update the default DESCRIPTION to adhere to openwashdata style}
\usage{
update_description(
  file = ".",
  github_user = "https://github.com/openwashdata/"
)
}
\arguments{
\item{file}{File path to an R package containing DESCRIPTION. Defaults to the current working package.}

\item{github_user}{URL path to the GitHub user or organization that hosts the current package. Defaults to https://github.com/openwashdata.}
}
\description{
This function updates the DESCRIPTION file of an R package to comply with openwashdata standards.
It adds or modifies fields such as doculicense, language, date, URL, etc.
}
\examples{
\dontrun{
update_description()
}

}
