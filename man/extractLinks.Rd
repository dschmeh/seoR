% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/extractLinks.R
\name{extractLinks}
\alias{extractLinks}
\title{Function to extract all links of a given Url.}
\usage{
extractLinks(url, linkType = "all", uniqueLinks = FALSE)
}
\arguments{
\item{url}{The url you want to extract the Links of}

\item{linkType}{The LinkType you want to analyze. All Links, Just Internal Links or Links to other Domains (external). You can specify "all","external" and "internal". Default is "all"}

\item{uniqueLinks}{Logical. Extract unique Links as one is TRUE. Default is FALSE
extractLinks()}
}
\description{
This function allows you to extract all links of a given URL. You can specify if you just want unique Links or all. The output is a Data Frame.
}
\examples{
extractLinks("https://www.r-project.org/", uniqueLinks = FALSE)
}
