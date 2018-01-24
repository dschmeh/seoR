#' Function to retrive the number of specified H-Tag for a given URL
#'
#' This function allows you to get the number of H-Tags you specified in the Call for a given URL.
#' @param url The URL you want to get the H-Tags for
#' @param hTag The H-Tags you want to get (exampale = h2-Tags). Default is H1
#' htag_count()
#' @examples
#' htag_count("https://www.r-project.org/", hTag = "h3")


htag_count <- function(url, hTag = "h1") {

  htag <- as.data.frame(try(url %>%
                              as.character() %>%
                              xml2::read_html() %>%
                              html_nodes(hTag) %>%
                              html_text())
  )
  return(nrow(htag))
}
