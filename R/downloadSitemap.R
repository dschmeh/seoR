#' Function to download the Sitemap.xml of a given Webpage
#'
#' This function allows to Download the Sitemap.xml of a given Webpage
#' @param sitemap The Sitemap you want to download. This can also be a Index-Sitemap
#' downloadSitemap()
#' @examples
#' downloadSitemap("http://ohren-reinigen.de/sitemap.xml")

downloadSitemap <- function(sitemap) {
  #Input check
  if(sitemapxml_check(sitemap) != TRUE) {
    warning("Please check you provided Sitemap")
  }
  #Get the Sitemap
  s <- XML::xmlToDataFrame(sitemap)
  #check if Sitemap is Index Sitemap
  if ((nrow(s) / sum(grepl("xml", s$loc))) > 0.8) {
    loop <- 0
    full_sm <- NULL

    for (i in 1:nrow(s)) {
      sm <- XML::xmlToDataFrame(as.character(s$loc[i]))
      full_sm <- rbind(full_sm, sm)
    }
  } else {
    full_sm <- s
  }
  return(full_sm)
}
