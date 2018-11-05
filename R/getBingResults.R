#' Function to retrive data from Google Suggest for a specific keyword
#'
#' The function allows you to get the search results from Bing. The Function extratcts just the organic Search results. the Output is a Dataframe containing, Title,Description, URL and Landing Page.
#' @param keyword The initial keyword you want the results for
#' @param results Number of results you want to get. 10 is the Limit.
#' @param market The Market of the search results https://docs.microsoft.com/en-us/rest/api/cognitiveservices/bing-web-api-v7-reference#market-codes
#' @param language The language of the search results
#' getBingResults()
#' @examples
#' getBingResults("R Project")

getBingResults <- function (keyword, results = 10, market = NULL, language = NULL) {
  if (results > 10) {
    warning("10 results are the Limit")
    results <- 10
  }
  
  if(is.null(market)){
  y <-
    xml2::read_html(paste0('http://www.bing.com/search?q=',
                           gsub(" ", "+", keyword)))
  } else {
    if(is.null(language)){
      language<-market
    }
    y <-
      xml2::read_html(paste0('http://www.bing.com/search?q=',
                             gsub(" ", "+", keyword),"&setmkt=",market,"&setlang=",language))  
  }
  descriptions <-
    utils::head(as.data.frame(
      y %>% rvest::html_nodes(".b_algo .b_caption p") %>% rvest::html_text()
    ),
    results)
  title <-
    utils::head(as.data.frame(y %>% rvest::html_nodes(".b_algo h2") %>% rvest::html_text()),
                results)
  url <-
    utils::head(as.data.frame(
      y %>% rvest::html_nodes(".b_algo cite") %>% rvest::html_text()
    ),
    results)
  landingPage <-
    utils::head(as.data.frame(
      y %>% rvest::html_nodes(".b_algo h2 a") %>% rvest::html_attr('href')
    ),
    results)
  names(title) = "Title"
  names(descriptions) = "description"
  names(url) = "url"
  names(landingPage) = "landingpage"
  return(list(title = title, description = descriptions, url = url, landingpage = landingPage))
}
