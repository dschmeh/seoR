#' Function to retrive the Meta-Description of a given URL
#'
#' This function allows you to get the Meta-Description of a specific URL.
#' @param url The URL you want to get the description for
#' HTMLdescription()
#' @examples
#' HTMLdescription("https://www.r-project.org/")

HTMLdescription <- function(url) {

  des <- try(url %>%
               as.character() %>%
               read_html() %>%
               html_nodes("meta[name=description]") %>%
               html_attr("content"))
  if (nrow(as.data.frame(des)) == 0) {
    return("No Description")
  } else {
    return(des)
  }
}
