#' Function to retrive Link Metrics from Moz-API
#'
#' This function allows you to get the Moz Link Metrics. You need a API Key to retrieve this Data. You can generate one for free here: https://moz.com/help/guides/moz-api/mozscape/getting-started-with-mozscape/create-and-manage-your-account At the Moment you just get the Data provided by a free Account.
#' @param page The page you want the data for
#' @param Access_ID Your Moz Access ID
#' @param Secret_Key Your Moz Secret Key
#' @param Scope indicates which links to return based on whether the target and source URLs are pages, domains, or subdomains.
#' @param Limit The default value of Limit is 1 and the maximum value is 50.
#' @param Filter  excludes results unless they meet criteria you specify. You can specify more than one value by separating multiple Filter parameters with a plus symbol +.
#' @param Sort Sort links results by:https://moz.com/help/guides/moz-api/mozscape/api-reference/link-metrics
#' @param SourceCols is a bit flag: a numerical value specifying which data to include about source URLs that link to the target URL.
#' @param TargetCols  is a bit flag: a numerical value specifying which data to include about the target URL.
#' @param LinkCols is a bit flag: a numerical value specifying which data to include about the link itself (for example, if the link is nofollowed).
#' mozLinkMetrics()
#' @examples
#' \dontrun{
#' page<-"https://www.r-project.org/"
#' Access_ID<-{{YOUR_ACCESS_ID}}
#' Secret_Key<-{{YOUR_SECRET_KEY}}
#' mozLinkMetrics(page, Access_ID, Secret_Key)
#' }


mozLinkMetrics <-
  function(page,
           Access_ID,
           Secret_Key,
           Scope = "page_to_page",
           Limit = 1,
           Filter = "",
           Sort = "",
           SourceCols = "536870916",
           TargetCols = "536870916",
           LinkCols = "") {
    #TODO: Add Error Handlings for Filter, Sorting, etc.
    #Generate the key
    if (Limit > 50) {
      warning("The Limit for the API is 50")
      Limit <- 50
    }
    timestamp <- round(as.numeric(as.POSIXct(Sys.time() + 300)))
    moz_call <-
      paste0(
        "http://lsapi.seomoz.com/linkscape/links/",
        URLencode(page),
        "?Scope=",
        Scope,
        if (Sort != '') {
          paste0("&Sort=", Sort)
        },
        if (Filter != '') {
          paste0("&Filter=", Filter)
        },
        "&Limit=",
        Limit,
        "&SourceCols=",
        SourceCols,
        "&TargetCols=",
        TargetCols,
        if (LinkCols != '') {
          paste0("&LinkCols=",
                 LinkCols)
        },
        "&AccessID=",
        Access_ID,
        "&Expires=",
        timestamp,
        "&Signature=",
        URLencode(RCurl::base64(
          digest::hmac(Secret_Key, paste0(Access_ID, '\n', timestamp), "sha1", raw = TRUE)
        ), reserved = TRUE)
      )
    res <- jsonlite::fromJSON(moz_call)
    return(res)
  }
