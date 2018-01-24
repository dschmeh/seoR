#' Function to retrive the Number of results for a given Keyword
#'
#' This function allows you to get the number of Results for a given Keyword. You can get the value even from Google or Bing, by specifing this in the Call.
#' @param keyword The keyword you want to get the number of results for
#' @param searchengine The Searchengine you want to get the results form. Even Google or Bing. Default is Google.
#' keywordResults()
#' @examples
#' keywordResults("R Project", searchengine = "google")


keywordResults <- function(keyword, searchengine = "google") {

  #SE Input error Handling missing
  if (searchengine == "google") {
    url <- paste0("https://www.google.com/search?q=", gsub(" ","+",keyword))
    res <- try(url %>%
                 as.character() %>%
                 xml2::read_html() %>%
                 html_nodes("#resultStats"))
    res <-
      stringr::str_extract(
        res,
        "[0-9]{0,3}(\\.|\\,){0,1}[0-9]{0,3}(\\.|\\,){0,1}[0-9]{0,3}(\\.|\\,){0,1}[0-9]{0,3}(\\.|\\,){0,1}[0-9]{1,3}"
      )
    return(res)
  } else {
    url <- paste0("https://www.bing.com/search?q=", keyword)
    res <- try(url %>%
                 as.character() %>%
                 xml2::read_html() %>%
                 html_nodes(".sb_count"))
    res <-
      stringr::str_extract(
        res,
        "[0-9]{0,3}(\\.|\\,){0,1}[0-9]{0,3}(\\.|\\,){0,1}[0-9]{0,3}(\\.|\\,){0,1}[0-9]{0,3}(\\.|\\,){0,1}[0-9]{1,3}"
      )
    return(res)
  }
}
