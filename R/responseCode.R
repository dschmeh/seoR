#' Function to get the Status Code of a given URL
#'
#' This function allows you to get the the status Code of a given URL
#' @url The URL you want to get the status Code for
#' responseCode()


responseCode <- function(url) {
  r <- httr::GET(url)
  return(r$status_code)
}
