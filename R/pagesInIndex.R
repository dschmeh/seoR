#' Function to retrive the number of indexed URLs for a given Domain or URL-String
#'
#' This function allows you to get the number of indexed URLs for a given Domain or URL-String. The Function performs a Google-Site request to gets the value.
#' @param url The url you want to get the number of results for
#' pagesInIndex()
#' @examples
#' pagesInIndex("https://www.r-project.org/")


pagesInIndex <- function(url) {
  url <- paste0("https://www.google.com/search?q=site:", URLencode(url))
  res <- try(url %>%
               as.character() %>%
               xml2::read_html() %>%
               html_nodes("#resultStats"))
  res <-
    stringr::str_extract(
      res,
      "[0-9]{0,3}(\\.|\\,){0,1}[0-9]{0,3}(\\.|\\,){0,1}[0-9]{0,3}(\\.|\\,){0,1}[0-9]{0,3}(\\.|\\,){0,1}[0-9]{1,3}"
    )
  return(res)
}
