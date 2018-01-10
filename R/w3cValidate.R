#' Function to preform a W3C Validation Test for a specific URL
#'
#' This function allows you to perform a W3C Validation test for a given URL. You will get the number of Errors and Warnings for the URL as Data Frame.
#' @param url The url you want to perform the Validation for
#' w3cValidate()
#' @examples
#' w3cValidate("https://www.r-project.org/")

w3cValidate <- function(url) {
  w3c <-
    read_html(paste0(
      "https://validator.w3.org/nu/?doc=",
      URLencode(url),
      "&out=json"
    ))
  #Count the errors in the document
  error_count <-
    as.data.frame(stringr::str_count(w3c, '.error...lastLine.'))
  warning_count <- as.data.frame(stringr::str_count(w3c, 'warning'))
  w3c <- cbind(error_count, warning_count)
  colnames(w3c) <- c("Errors", "Warnings")
  return(w3c)
}
