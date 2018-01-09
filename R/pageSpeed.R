#' Function to retrieve Data from Googles Pagespeed Testing API
#'
#' This function allows you to retrive Data from Googles Pagespeed Testing API. The Function retrives the data (a numeric value between 0 and 100) for a given Url.
#' @param url The Url you want to perform the test for.
#' @param APIToken Your API Token for this Google Project. Please use your own token if you perform a lot of calls.
#' pageSpeed()


pageSpeed <-
  function(url, APIToken = "AIzaSyC1gUZEsqk-nny6f3KnJyTKuy30O6fpGCw") {
    x <-
      jsonlite::fromJSON(
        paste0(
          "https://www.googleapis.com/pagespeedonline/v2/runPagespeed?url=",
          URLencode(url),
          "&key=",
          APIToken
        )
      )
    return(as.numeric(x$ruleGroups$SPEED))
  }
