#' Function to get the Status Code of a given URL
#'
#' This function allows you to get the the status Code of a given URL
#' @param url The URL you want to get the status Code for
#' responseCode()
#' @examples
#' responseCode("https://www.r-project.org/")

responseCode <- function(url) {
  r <- curlGetHeaders(url, redirect = FALSE)
  status<-stringr::str_extract(r[1],"[0-9]{3}")
  return(status)
}
