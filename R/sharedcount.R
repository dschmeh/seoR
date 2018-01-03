#' Function to get the Social Shares for a given URL
#'
#' This function allows to get the shares of a given Domain into R. Therefore the function uses the Sharedcount-API. To use the function you have to set up a free API-Account here: https://www.sharedcount.com/
#' @url The URL you want to analyze
#' @key Your API-Key you get from https://www.sharedcount.com/ fro free
#' sharedcount()


sharedcount <- function(url, key) {
  if (isTRUE(url_with_http(url))) {
  } else {
    warning("Please provide a URL like: http://www.example.com")
  }
  sc <-
    jsonlite::fromJSON(paste0(
      "https://api.sharedcount.com/v1.0/?url=",
      url,
      "&apikey=",
      key
    ))
  out <-
    as.data.frame(cbind(
      url,
      sc$Facebook$total_count,
      sc$Pinterest,
      sc$LinkedIn,
      sc$StumbleUpon
    ))
  out$all <-
    sum(
      as.numeric(as.character(out[, 2])),
      as.numeric(as.character(out[, 3])),
      as.numeric(as.character(out[, 4])),
      as.numeric(as.character(out[, 5]))
    )
  colnames(out) <-
    c("URL",
      "Facebook",
      "Pinterest",
      "Linkedin",
      "StumbleUpon",
      "All_Shares")
  return(out)
}
