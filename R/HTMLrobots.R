#' Function to retrive the Meta Robots for a given URL
#'
#' This function allows you to get the Meta Robots for a given URL.
#' @url The URL you want to get the Meta Robots for
#' HTMLrobots()



HTMLrobots <- function(url) {
  require(magrittr)
  require(rvest)
  try(url %>%
        as.character() %>%
        read_html() %>%
        html_nodes("meta[name=robots]") %>%
        html_attr("content"))
}
