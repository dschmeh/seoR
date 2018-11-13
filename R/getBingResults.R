#' Function to retrive data from Google Suggest for a specific keyword
#'
#' The function allows you to get the search results from Bing. The Function extratcts just the organic Search results. the Output is a Dataframe containing, Title,Description, URL and Landing Page.
#' @param keyword The initial keyword you want the results for
#' @param results Number of results you want to get. 10 is the Limit.
#' @param market The Market of the search results https://docs.microsoft.com/en-us/rest/api/cognitiveservices/bing-web-api-v7-reference#market-codes
#' @param language The language of the search results
#' getBingResults()
#' @examples
#' \dontrun{
#' getBingResults("R Project")
#' }

getBingResults <- function (keyword, results = 10, market = NULL, language = NULL) {
  require(magrittr)
  require(rvest)

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
    10)
  title <-
    utils::head(as.data.frame(y %>% rvest::html_nodes(".b_algo h2") %>% rvest::html_text()),
                10)
  url <-
    utils::head(as.data.frame(
      y %>% rvest::html_nodes(".b_algo cite") %>% rvest::html_text()
    ),
    10)
  landingPage <-
    utils::head(as.data.frame(
      y %>% rvest::html_nodes(".b_algo h2 a") %>% rvest::html_attr('href')
    ),
    10)
  
  if (results > 10) {
    descriptions_l<-NULL;
    title_l<-NULL;
    url_l<-NULL;
    landingPage_l<-NULL;
    rr<-(results-10)/10
    for(i in 1:rr){
      print(i)
      if(is.null(market)){
        y <-
          xml2::read_html(paste0('http://www.bing.com/search?q=',
                                 gsub(" ", "+", keyword),"&first=",i,"1"))
      } else {
        if(is.null(language)){
          language<-market
        }
        y <-
          xml2::read_html(paste0('http://www.bing.com/search?q=',
                                 gsub(" ", "+", keyword),"&setmkt=",market,"&setlang=",language,"&first=",i,"1"))  
      }
      descriptions_l[[i]] <-
        utils::head(as.data.frame(
          y %>% rvest::html_nodes(".b_algo .b_caption p") %>% rvest::html_text()
        ),
        10)
      names(descriptions_l[[i]]) = "description"
      title_l[[i]] <-
        utils::head(as.data.frame(y %>% rvest::html_nodes(".b_algo h2") %>% rvest::html_text()),
                    10)
      names(title_l[[i]]) = "Title"
      url_l[[i]] <-
        utils::head(as.data.frame(
          y %>% rvest::html_nodes(".b_algo cite") %>% rvest::html_text()
        ),
        10)
      names(url_l[[i]]) = "url"
      landingPage_l[[i]] <-
        utils::head(as.data.frame(
          y %>% rvest::html_nodes(".b_algo h2 a") %>% rvest::html_attr('href')
        ),
        10)
      names(landingPage_l[[i]]) = "landingpage"
    }
    landingPage_l<-do.call("rbind", landingPage_l)
    url_l<-do.call("rbind", url_l)
    title_l<-do.call("rbind", title_l)
    descriptions_l<-do.call("rbind", descriptions_l)
  }
  
  names(title) = "Title"
  names(descriptions) = "description"
  names(url) = "url"
  names(landingPage) = "landingpage"
  
  title<-rbind(title,title_l)
  url<-rbind(url,url_l)
  descriptions<-rbind(descriptions,descriptions_l)
  landingPage<-rbind(landingPage,landingPage_l)
  
  return(list(title = title, description = descriptions, url = url, landingpage = landingPage))
}
