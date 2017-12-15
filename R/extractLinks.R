#' Function to extract all links of a given Url.
#'
#' This function allows you to extract all links of a given URL. You can specify if you just want unique Links or all. The output is a Data Frame.
#' @url The url you want to extract the Links of
#' @uniqueLinks Logical. Extract unique Links as one is TRUE. Default is FALSE
#' extractLinks()



extractLinks <- function(url, uniqueLinks = FALSE) {
  require(magrittr)
  require(rvest)
  links <- try(as.data.frame(url %>%
                               as.character() %>%
                               read_html() %>%
                               html_nodes("a") %>%
                               html_attr("href")))
  colnames(links)[1] <- "links"
  if (uniqueLinks == FALSE)	{
    return(links)
  } else {
    return(unique(links))
  }
}
