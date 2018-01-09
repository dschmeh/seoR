#' Function to retrieve Data from Googles Mobile Friendly Testing API
#'
#' This function allows you to retrive Data from Googles Mobile Friendly Test API. The Function retrives the data for a given Url. The API provides you a TRUE for "is mobile friendly" and FALSE for "is not mobile friendly"
#' @param domain The Url you want to perform the test for.
#' @param APIToken Your API Token for this Google Project. Please use your own token if you perform a lot of calls.
#' mobileFriendly()



mobileFriendly <-
  function(domain, APIToken = "AIzaSyC1gUZEsqk-nny6f3KnJyTKuy30O6fpGCw") {
    if (APIToken == "AIzaSyC1gUZEsqk-nny6f3KnJyTKuy30O6fpGCw") {
      warning("Please Setup your own API-Key")
    }
    args <- list(url = domain)
    call <-
      paste0(
        "https://searchconsole.googleapis.com/v1/urlTestingTools/mobileFriendlyTest:run?key=",
        APIToken
      )
    mf <-
      POST(call, body = jsonlite::toJSON(args, auto_unbox = TRUE), verbose())
    if (mf$status_code == 200) {
      mm <- jsonlite::fromJSON(rawToChar(mf$content))
      return(mm$mobileFriendliness)
    } else
    {
      return(paste0("Could not retrieve Data. Status Code: ", mf$status_code))
    }
  }
