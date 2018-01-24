#' Function to retrive the Title of a given URL
#'
#' This function allows you to get the title of a specific URL.
#' @param url The URL you want to get the title for
#' HTMLtitle()
#' @examples
#' HTMLtitle("https://www.r-project.org/")

HTMLtitle <- function(url) {

  title <- try(url %>%
                 as.character() %>%
                 xml2::read_html() %>%
                 html_nodes("title"))
  title <- gsub("</?title>", "", title)
  return(as.character(title))
}
