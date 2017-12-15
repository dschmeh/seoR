#' Function to retrive the number of outgoing links for a given Url.
#'
#' This function allows you to get the number of outgoing links for a given URL.You can specify if you want to count same Links as one or not.
#' @url The url you want to get the number of outgoing links for
#' @uniqueLinks Logical. Count unique Links as one is TRUE. Default is FALSE
#' linkCount()



linkCount <- function(url, uniqueLinks = FALSE) {
  require(magrittr)
  require(rvest)
  links <- try(as.data.frame(url %>%
                               as.character() %>%
                               read_html() %>%
                               html_nodes("a") %>%
                               html_attr("href")))
  if (uniqueLinks == FALSE)	{
    return(nrow(links))
  } else {
    return(nrow(unique(links)))
  }
}
