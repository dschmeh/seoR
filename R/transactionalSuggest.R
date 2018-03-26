#' Function to retrive data from Amazon or eBay Suggest function for a given Keyword
#'
#' This function allows you to get more longtail Keywords for a specific given Keyword. The Tool uses the Google Autocomplete function to retrieve this keywords.
#' @param keyword The initial keyword you want to get suggestions for
#' @param language The language you want to get suggestions. Default is en.
#' @param page The Page you want to get the Suggestions from amazon or eBay. Default is amazon.
#' googleSuggest()
#' @examples
#' \dontrun{
#' transactionalSuggest(keyword = "t shirt", language = "en_US", page = "amazon")
#' }

transactionalSuggest <-
  function(keyword,
           language = "en_US",
           page = "amazon") {
    #Language Input check
    if (nchar(language) > 5) {
      warning("Please check your language input")
    }
    if(language == "en_US"){
      code<-"3"
    } else {
    if(language == "de_DE"){
      code<-"4"
    } else {
    if(language == "fr_FR"){
      code<-"5"
    } else {return("Country Code not Supported. Try 'de_DE', 'en_US' or 'fr_FR'")}}}
    keyword <- gsub(" |-", "+", keyword)
    if (page == 'amazon') {
      key <- xml2::read_html(
        paste0(
          "https://completion.amazon.co.uk/search/complete?method=completion&mkt=",code,"&r=Z2KMSHJE28XWX10D3122&s=262-9080112-1961654&c=A3O34B1E9N77BF&p=Gateway&l=",
          language,
          "&b2b=0&fresh=0&sv=desktop&client=amazon-search-ui&x=String&search-alias=aps&ks=83&q=",
          keyword,
          "&qs=&cf=1&fb=1&sc=1&"
        )
      )
      sug<-as.data.frame(str_extract_all(as.character(key), '\\"[a-zA-Z0-9 ]*\\"'))
      if(nrow(sug)>0){
      colnames(sug)<-c("suggestions")
      ll<-which(grepl("nodes", sug$suggestions))
      sug <- try(head(sug, if (as.numeric(length(ll)) > 0) {
        ll - 1
      } else {
        nrow(sug) - 1
      })
      )
      sug<-try(utils::tail(sug, nrow(sug)-2))
      cat<-as.data.frame(str_extract_all(as.character(key), 'alias\\"\\:\\"[a-zA-Z0-9 ]*\\"'))
      colnames(cat)<-c("category")
      cat<-as.character(gsub('alias\\"\\:','',cat$category[1]))
      sug$category<-cat
      }
      return(unique(sug))}
    else{
      return("No Suggestions")
    }
    }
