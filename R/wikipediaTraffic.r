#' Function to get Pageview Data of a given Wikipedia Article
#'
#' This function allows to get the pageviews for a given Wikiepdia article.
#' @param project The Wikipedia Project you want to retrieve the data from. Default is en.wikipedia.org. A list of possible projects can be found here <https://meta.wikimedia.org/w/api.php?action=sitematrix&formatversion=2>
#' @param page The Page you want to get the traffic for for example cat.
#' @param start The start date. Format = YYYY-MM-DD
#' @param end The end date. Format = YYYY-MM-DD
#' @param platform One of: all-access (default), desktop, mobile-app, mobile-web
#' @param agent One of 'user' (human reader, standard), 'spider' (search engine crawler), 'bot' (WMF bots) or 'all-agents'(user, spider and bot)
#' @param granularity The time unit for the response data. As of today, the only supported granularity for this endpoint is daily and monthly.
#' wikipediaTraffic()
#' @examples
#' wikipediaTraffic("R (programming language)",'2018-01-01','2018-01-10')

wikipediaTraffic <-
  function(page ,
           start,
           end ,
           project = "en.wikipedia.org",
           platform = "all-access",
           agent = "user",
           granularity = "daily") {
    #TODO: Write input tests
    y<-jsonlite::fromJSON(paste0(
      "https://wikimedia.org/api/rest_v1/metrics/pageviews/per-article/",
      project,
      "/",
      platform,
      "/",
      agent,
      "/",
      gsub(" ","_",page),
      "/",
      granularity,
      "/",
      gsub("-","",start),
      "/",
      gsub("-","",end)
    ))
    return(y$items)
  }
