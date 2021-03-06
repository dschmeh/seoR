#' Function to retrive data from Google Suggest for a specific keyword
#'
#' This function allows you to get more longtail Keywords for a specific given Keyword. The Tool uses the Google Autocomplete function to retrieve this keywords.
#' @param keyword The initial keyword you want to get suggestions for
#' @param walkThrough logical Input. If TRUE the function adds every letter before and after the keyword to loop through the Google Autocomplete.
#' @param language The language you want to get suggestions. Default is en.
#' @param questions Logial. Checks for keywords with question-Phrases like "How much is beer"
#' @param prepositions Logial. Checks for keywords with prepositions-Phrases like "beer without alcohol"
#' @param comparisons Logial. Checks keywords with comparison phrase like "beer versus wine"
#' googleSuggest()
#' @examples
#' \dontrun{
#' googleSuggest("R Project", language = "en", walkThrough = FALSE)
#' }

googleSuggest <-
  function(keyword,
           language = "en",
           suggestions = TRUE,
           walkThrough = FALSE,
           questions = FALSE,
           prepositions = FALSE,
           comparisons = FALSE) {
    #Language Input check
    if (nchar(language) > 2) {
      warning("Please check your language input")
    }
    #walkThrough-Input check
    if (!is.logical(walkThrough)) {
      stop("The walkThrough should be a logical input")
    }
    keyword <- gsub(" ", "+", keyword)
    if (suggestions == TRUE) {
    key <- xml2::read_html(
      paste0(
        "http://suggestqueries.google.com/complete/search?output=toolbar&hl=",
        language,
        "&q=",
        keyword
      )
    )
    sug <- xml2::xml_find_all(key, "//suggestion")
    sug <- gsub('<suggestion data="', "", sug)
    sug <- gsub('"></suggestion>', "", sug)
    sug <- as.data.frame(sug)
    colnames(sug) <- "keyword_suggestions"} else {sug<-NULL;}
    # Walk through the alphabte for the given keyword (maybe add numbers)
    if (walkThrough == TRUE) {
      alphabet <- as.data.frame(c(letters))
      for (i in 1:nrow(alphabet)) {
        #query with alphabte after keyword
        key <- xml2::read_html(
          paste0(
            "http://suggestqueries.google.com/complete/search?output=toolbar&hl=",
            language,
            "&q=",
            paste0(keyword, "+", alphabet[i, 1])
          )
        )
        s <- xml2::xml_find_all(key, "//suggestion")
        s <- gsub('<suggestion data="', "", s)
        s <- gsub('"></suggestion>', "", s)
        s <- as.data.frame(s)
        colnames(s) <- "keyword_suggestions"
        #query with alphabte before keyword
        key <- xml2::read_html(
          paste0(
            "http://suggestqueries.google.com/complete/search?output=toolbar&hl=",
            language,
            "&q=",
            paste0(alphabet[i, 1], "+", keyword, "+")
          )
        )
        ss <- xml2::xml_find_all(key, "//suggestion")
        ss <- gsub('<suggestion data="', "", ss)
        ss <- gsub('"></suggestion>', "", ss)
        ss <- as.data.frame(ss)
        colnames(ss) <- "keyword_suggestions"
        sug <- rbind(sug, s, ss)
      }
    }
    
    #Check the Keywords with question words
    
    if (isTRUE(questions)) {
      file <- paste0('~/seoR/data-raw/questions_', language, '.csv')
      questions <- readr::read_csv(file,
                                   col_names = FALSE)
      for (i in 1:nrow(questions)) {
        #query with question keyword
        key <- xml2::read_html(
          paste0(
            "http://suggestqueries.google.com/complete/search?output=toolbar&hl=",
            language,
            "&q=",
            gsub(" ", "+", paste0(questions[i, 1], "+", keyword))
          )
        )
        s <- xml2::xml_find_all(key, "//suggestion")
        s <- gsub('<suggestion data="', "", s)
        s <- gsub('"></suggestion>', "", s)
        s <- as.data.frame(s)
        colnames(s) <- "keyword_suggestions"
        sug <- rbind(sug, s)
      }
    }
    
    #Check the Keywords with prepositions words
    
    if (isTRUE(prepositions)) {
      file <- paste0('~/seoR/data-raw/prepositions_', language, '.csv')
      prepositions <- readr::read_csv(file)
      for (i in 1:nrow(prepositions)) {
        #query with prepositions keyword
        key <- xml2::read_html(
          paste0(
            "http://suggestqueries.google.com/complete/search?output=toolbar&hl=",
            language,
            "&q=",
            gsub(" ", "+", paste0(keyword, "+", prepositions[i, 1]))
          )
        )
        s <- xml2::xml_find_all(key, "//suggestion")
        s <- gsub('<suggestion data="', "", s)
        s <- gsub('"></suggestion>', "", s)
        s <- as.data.frame(s)
        colnames(s) <- "keyword_suggestions"
        sug <- rbind(sug, s)
      }
    }
    
    #Check the Keywords with comparisons words
    
    if (isTRUE(comparisons)) {
      file <- paste0('~/seoR/data-raw/comparisons_', language, '.csv')
      comparisons <- readr::read_csv(file)
      for (i in 1:nrow(comparisons)) {
        #query with comparisons keyword
        key <- xml2::read_html(
          paste0(
            "http://suggestqueries.google.com/complete/search?output=toolbar&hl=",
            language,
            "&q=",
            gsub(" ", "+", paste0(keyword, "+", comparisons[i, 1]))
          )
        )
        s <- xml2::xml_find_all(key, "//suggestion")
        s <- gsub('<suggestion data="', "", s)
        s <- gsub('"></suggestion>', "", s)
        s <- as.data.frame(s)
        colnames(s) <- "keyword_suggestions"
        sug <- rbind(sug, s)
      }
    }
    
    return(unique(sug))
  }
