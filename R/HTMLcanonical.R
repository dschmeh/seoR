#' Function to retrive the Canonical Link element for a given URL
#'
#' This function allows you to get the canonical Link element for a given URL.
#' @param url The URL you want to get the Canonical-Tag for
#' HTMLcanonical()



HTMLcanonical <- function(url) {

  can <- as.data.frame(try(url %>%
                             as.character() %>%
                             read_html() %>%
                             stringr::str_extract('rel="canonical" href=.*'))
  )
  if (is.na(can[1, 1])) {
    return(
      "No Canonical-Tag")
  } else {
    can <- stringr::str_extract(can[1, 1], 'http.*[a-zA-Z]{2,3}')
    return(can)
  }
}
