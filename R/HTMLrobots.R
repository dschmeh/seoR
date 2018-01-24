#' Function to retrive the Meta Robots for a given URL
#'
#' This function allows you to get the Meta Robots for a given URL.
#' @param url The URL you want to get the Meta Robots for
#' HTMLrobots()
#' @examples
#' HTMLrobots("https://www.r-project.org/")


HTMLrobots <- function(url) {
  try(url %>%
        as.character() %>%
        xml2::read_html() %>%
        html_nodes("meta[name=robots]") %>%
        html_attr("content"))
}
