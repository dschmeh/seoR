#' Function to retrive URL Metrics from Moz-API
#'
#' This function allows you to get the Moz URL Metrics. You need a API Key to retrieve this Data. You can generate one for free here: https://moz.com/help/guides/moz-api/mozscape/getting-started-with-mozscape/create-and-manage-your-account At the Moment you just get the Data provided by a free Account.
#' @param page The page you want the data for
#' @param Access_ID Your Moz Access ID
#' @param Secret_Key Your Moz Secret Key
#' mozUrlMetrics()
#' @examples
#' \dontrun{
#' page<-"https://www.r-project.org/"
#' Access_ID<-{{YOUR_ACCESS_ID}}
#' Secret_Key<-{{YOUR_SECRET_KEY}}
#' mozUrlMetrics(page, Access_ID, Secret_Key)
#' }

mozUrlMetrics <- function(page, Access_ID, Secret_Key) {
  #TODO: Add the possibility to specific Cols
  #Generate the key
  timestamp <- round(as.numeric(as.POSIXct(Sys.time() + 300)))
  moz_call <-
    paste0(
      "http://lsapi.seomoz.com/linkscape/url-metrics/",
      URLencode(page),
      "?Cols=103616137253&AccessID=",
      Access_ID,
      "&Expires=",
      timestamp,
      "&Signature=",
      URLencode(digest::base64(
        hmac(Secret_Key, paste0(Access_ID, '\n', timestamp), "sha1", raw = TRUE)
      ), reserved = TRUE)
    )
  res <- jsonlite::fromJSON(moz_call)
  urlMetr <-
    cbind(
      as.data.frame(res$uu),
      as.data.frame(res$ut),
      as.data.frame(res$us),
      as.data.frame(res$upa),
      as.data.frame(res$umrr),
      as.data.frame(res$umrp),
      as.data.frame(res$uid),
      as.data.frame(res$ueid),
      as.data.frame(res$pda),
      as.data.frame(res$fmrr),
      as.data.frame(res$fmrp)
    )
  colnames(urlMetr) <-
    c(
      "Canonical",
      "title",
      "HTTP_Status_Code",
      "Page_Authority",
      "MozRank_URL_raw",
      "MozRank_URL_point",
      "Links",
      "External_Equity_Links",
      "Domain_Authority",
      "MozRank_Subdomain_raw",
      "MozRank_Subdomain_point"
    )
  return(urlMetr)
}
