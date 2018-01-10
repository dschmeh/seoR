#' Function to retrive the specified H-Tag of a URL as a Data Frame
#'
#' This function allows you to get the H-Tags you specified in the Call of a given URL. The function returns the H-Tags as Data Frame.
#' @param url The URL you want to get the H-Tags for
#' @param hTag The H-Tags you want to get (exampale = h2-Tags). Default is H1
#' htag()
#' @examples
#' htag("https://www.r-project.org/", hTag = "h1")


htag <- function(url, hTag = "h1") {

  htag <- as.data.frame(try(url %>%
                              as.character() %>%
                              read_html() %>%
                              html_nodes(hTag) %>%
                              html_text())
  )
  colnames(htag)[1]  <-  hTag
  return(htag)
}
