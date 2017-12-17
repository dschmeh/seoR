#' Function to retrive data from Google Suggest for a specific keyword
#'
#' This function allows you to get more longtail Keywords for a specific given Keyword. The Tool uses the Google Autocomplete function to retrieve this keywords.
#' @keyword The initial keyword you want to get suggestions for
#' @walkThrough logical Input. If TRUE the function adds every letter before and after the keyword to loop through the Google Autocomplete.
#' @language The language you want to get suggestions. Default is en.
#' googleSuggest()

googleSuggest <-
  function(keyword,
           language = "en",
           walkThrough = FALSE) {
    require(magrittr)
    require(rvest)
    #Language Input check
    if (nchar(language) > 2) {
      warning("Please check your language input")
    }
    #walkThrough-Input check
    if (!is.logical(walkThrough)) {
      stop("The walkThrough should be a logical input")
    }
    keyword <- gsub(" ", "+", keyword)
    key <- read_html(
      paste0(
        "http://suggestqueries.google.com/complete/search?output=toolbar&hl=",
        language,
        "&q=",
        keyword
      )
    )
    sug <- xml_find_all(key, "//suggestion")
    sug <- gsub('<suggestion data="', "", sug)
    sug <- gsub('"></suggestion>', "", sug)
    sug <- as.data.frame(sug)
    colnames(sug) <- "keyword_suggestions"
    # Walk through the alphabte for the given keyword (maybe add numbers)
    if (walkThrough == TRUE) {
      alphabet <- as.data.frame(c(letters))
      for (i in 1:nrow(alphabet)) {
        #query with alphabte after keyword
        key <- read_html(
          paste0(
            "http://suggestqueries.google.com/complete/search?output=toolbar&hl=",
            language,
            "&q=",
            paste0(keyword, "+", alphabet[i, 1])
          )
        )
        s <- xml_find_all(key, "//suggestion")
        s <- gsub('<suggestion data="', "", s)
        s <- gsub('"></suggestion>', "", s)
        s <- as.data.frame(s)
        colnames(s) <- "keyword_suggestions"
        #query with alphabte after keyword
        key <- read_html(
          paste0(
            "http://suggestqueries.google.com/complete/search?output=toolbar&hl=",
            language,
            "&q=",
            paste0(alphabet[i, 1], "+", keyword, "+")
          )
        )
        ss <- xml_find_all(key, "//suggestion")
        ss <- gsub('<suggestion data="', "", ss)
        ss <- gsub('"></suggestion>', "", ss)
        ss <- as.data.frame(ss)
        colnames(ss) <- "keyword_suggestions"
        sug <- rbind(sug, s, ss)
      }
    }
    return(unique(sug))
  }
