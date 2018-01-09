#' Function to check if a given URL is in a XML-Sitemap
#'
#' This function allows you to check if a given URL is found in a XML-Sitemap. For this you can also put in your Index-Sitemap.
#' @param url The URL you want to check
#' @param sitemap The Link to the Sitemap you want to find the URL in
#' urlInSitemap()

urlInSitemap <- function(url, sitemap) {
  s <- XML::xmlToDataFrame(sitemap)
  #check if Sitemap is Index Sitemap
  if ((nrow(s) / sum(grepl("xml", s$loc))) > 0.8) {
    loop <- 0
    for (i in 1:nrow(s)) {
      sm <- XML::xmlToDataFrame(as.character(s$loc[i]))
      if (sum(grepl(url, sm$loc)) > 0) {
        out_l <- 1
      } else {
        out_l <- 0
      }
      loop <- (as.numeric(loop) + as.numeric(out_l))
    }
    if (loop > 0) {
      out <- TRUE
    } else {
      out <- FALSE
    }
  } else
  {
    if (sum(grepl(url, s$loc)) > 0) {
      out <- TRUE
    } else {
      out <- FALSE
    }
  }
  return(out)
}
