#' Function to retrive the Title of a given URL
#'
#' This function allows you to get the title of a specific URL.
#' @param url The URL you want to get the title for
#' HTMLtitle()


HTMLtitle <- function(url) {

  title <- try(url %>%
                 as.character() %>%
                 read_html() %>%
                 html_nodes("title"))
  title <- gsub("</?title>", "", title)
  return(as.character(title))
}
