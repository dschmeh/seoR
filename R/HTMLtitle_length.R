#' Function to retrive the number of characters a Title-Tag contains for a given URL
#'
#' This function allows you to get the number of characters in a Title-Tag for a given URL.
#' @param url The URL you want to get the title length for
#' HTMLtitle_length()


HTMLtitle_length <- function(url) {

  title <- try(url %>%
                 as.character() %>%
                 read_html() %>%
                 html_nodes("title"))
  title <- gsub("</?title>", "", title)
  return(nchar(as.character(title)))
}
