#' Function to retrive the Meta-Description of a given URL
#'
#' This function allows you to get the Meta-Description of a specific URL.
#' @url The URL you want to get the description for
#' HTMLdescription()


HTMLdescription <- function(url) {
  require(magrittr)
  require(rvest)
  try(url %>%
        as.character() %>%
        read_html() %>%
        html_nodes("meta[name=description]") %>%
        html_attr("content"))
}
