#' Function to retrive the number of characters a Meta Description contains for a given URL
#'
#' This function allows you to get the number of characters in a Meta Description for a given URL.
#' @url The URL you want to get the description length for
#' HTMLdescription_length()

HTMLdescription_length <- function(url) {
  requireNamespace(magrittr)
  requireNamespace(rvest)
  des <- try(url %>%
               as.character() %>%
               read_html() %>%
               html_nodes("meta[name=description]") %>%
               html_attr("content"))
   if (nrow(as.data.frame(des)) == 0) {
    return("No Description")
  } else {
    return(nchar(des, type = "chars"))
  }
}
