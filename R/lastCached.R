#' Function to get the last Google Cache Date for a URL
#'
#' This function allows you to get the latest Google Cache Date for a given URL.
#' @url The url you want to get the Cache Date
#' lastCached()


lastCached <- function(url) {
  url <-
    paste0("http://webcache.googleusercontent.com/search?q=cache:",
           url)
  res <- try(url %>%
               as.character() %>%
               read_html() %>%
               html_nodes("#google-cache-hdr > div:nth-child(1)"))
  res <-
    stringr::str_extract(
      res,
      "([0-9]{1,2}..[a-zA-Z]{1,3}..[0-9]{4}|[a-zA-Z]{1,3}.[0-9]{1,2}\\,.[0-9]{4}).[0-9]{2}\\:[0-9]{2}\\:[0-9]{2}"
    )
  if (is.na(res)) {
    return("Page not cached")
  } else {
    return(res)
  }
}
