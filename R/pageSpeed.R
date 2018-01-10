#' Function to retrieve Data from Googles Pagespeed Testing API
#'
#' This function allows you to retrive Data from Googles Pagespeed Testing API. The Function retrives the data (a numeric value between 0 and 100) for a given Url.
#' @param url The Url you want to perform the test for.
#' @param APIToken Your API Token for this Google Project. Please use your own token if you perform a lot of calls.
#' @param strategy Character. Choose if you want to get the data for "mobile" or "desktop"
#' @param pageStats Logical. Do you want to get the Pagestats from the API? Default is TRUE
#' @param speedScore Logical. If TRUE you just get the Pagespeed Score Number. Default is FALSE
#' pageSpeed()
#' @examples
#' pageSpeed("https://www.r-project.org/")

pageSpeed <-
  function(url,
           APIToken = "AIzaSyC1gUZEsqk-nny6f3KnJyTKuy30O6fpGCw",
           strategy = "mobile",
           pageStats = FALSE,
           speedScore = FALSE) {
    x <-
      jsonlite::fromJSON(
        paste0(
          "https://www.googleapis.com/pagespeedonline/v4/runPagespeed?url=",
          URLencode(url),
          "&strategy=",
          strategy,
          "&key=",
          APIToken
        )
      )
    if (isTRUE(speedScore)) {
      return(as.numeric(x$ruleGroups$SPEED))
    } else
    {
      if (isTRUE(pageStats)) {
        ret <- as.data.frame(
          cbind(
            x$ruleGroups$SPEED$score,
            if (!is.null(x$loadingExperience$metrics$FIRST_CONTENTFUL_PAINT_MS$median)) {
              x$loadingExperience$metrics$FIRST_CONTENTFUL_PAINT_MS$median
            },
            if (!is.null(x$loadingExperience$metrics$FIRST_CONTENTFUL_PAINT_MS$category)) {
              as.character(x$loadingExperience$metrics$FIRST_CONTENTFUL_PAINT_MS$category)
            },
            if (!is.null(x$loadingExperience$metrics$DOM_CONTENT_LOADED_EVENT_FIRED_MS$median)) {
              x$loadingExperience$metrics$DOM_CONTENT_LOADED_EVENT_FIRED_MS$median
            },
            if (!is.null(x$loadingExperience$metrics$DOM_CONTENT_LOADED_EVENT_FIRED_MS$category)) {
              as.character(x$loadingExperience$metrics$DOM_CONTENT_LOADED_EVENT_FIRED_MS$category)
            },
            if (!is.null(x$loadingExperience$overall_category)) {
              x$loadingExperience$overall_category
            },
            x$pageStats$numberResources,
            x$pageStats$numberHosts,
            x$pageStats$totalRequestBytes,
            x$pageStats$numberStaticResources,
            x$pageStats$htmlResponseBytes,
            x$pageStats$overTheWireResponseBytes,
            x$pageStats$cssResponseBytes,
            x$pageStats$imageResponseBytes,
            x$pageStats$javascriptResponseBytes,
            x$pageStats$otherResponseBytes,
            x$pageStats$numberJsResources,
            x$pageStats$numberCssResources,
            x$pageStats$numTotalRoundTrips,
            x$pageStats$numRenderBlockingRoundTrips
          )
        )
        colnames(ret) <-
          c(
            "SPEED_score",
            if (!is.null(x$loadingExperience$metrics$FIRST_CONTENTFUL_PAINT_MS$median)) {
              "FIRST_CONTENTFUL_PAINT_MS_median"
            },
            if (!is.null(x$loadingExperience$metrics$FIRST_CONTENTFUL_PAINT_MS$category)) {
              "FIRST_CONTENTFUL_PAINT_MS_category"
            },
            if (!is.null(x$loadingExperience$metrics$DOM_CONTENT_LOADED_EVENT_FIRED_MS$median)) {
              "DOM_CONTENT_LOADED_EVENT_FIRED_MS_median"
            },
            if (!is.null(x$loadingExperience$metrics$DOM_CONTENT_LOADED_EVENT_FIRED_MS$category)) {
              "DOM_CONTENT_LOADED_EVENT_FIRED_MS_category"
            },
            if (!is.null(x$loadingExperience$overall_category)) {
              "loadingExperience_overall_category"
            },
            "pageStats_numberResources",
            "pageStats_numberHosts",
            "pageStats_totalRequestBytes",
            "pageStats_numberStaticResources",
            "pageStats_htmlResponseBytes",
            "pageStats_overTheWireResponseBytes",
            "pageStats_cssResponseBytes",
            "pageStats_imageResponseBytes",
            "pageStats_javascriptResponseBytes",
            if (!is.null(x$pageStats$otherResponseBytes)) {
            "pageStats_otherResponseBytes"},
            "pageStats_numberJsResources",
            "pageStats_numberCssResources",
            "pageStats_numTotalRoundTrips",
            "pageStats_numRenderBlockingRoundTrips"
          )
        return(ret)
      } else {
        ret <- as.data.frame(cbind(x$ruleGroups$SPEED$score,
                                   if (!is.null(x$loadingExperience$metrics$FIRST_CONTENTFUL_PAINT_MS$median))  {
                                     x$loadingExperience$metrics$FIRST_CONTENTFUL_PAINT_MS$median
                                   },
                                   if (!is.null(x$loadingExperience$metrics$FIRST_CONTENTFUL_PAINT_MS$category))  {
                                     as.character(x$loadingExperience$metrics$FIRST_CONTENTFUL_PAINT_MS$category)
                                   },
                                   if (!is.null(x$loadingExperience$metrics$DOM_CONTENT_LOADED_EVENT_FIRED_MS$median))  {
                                     x$loadingExperience$metrics$DOM_CONTENT_LOADED_EVENT_FIRED_MS$median
                                   },
                                   if (!is.null(x$loadingExperience$metrics$DOM_CONTENT_LOADED_EVENT_FIRED_MS$category))  {
                                     as.character(x$loadingExperience$metrics$DOM_CONTENT_LOADED_EVENT_FIRED_MS$category)
                                   },
                                   if (!is.null(x$loadingExperience$overall_category))  {
                                     x$loadingExperience$overall_category
                                   }))
        colnames(ret) <-
          c("SPEED_score",
            if (!is.null(x$loadingExperience$metrics$FIRST_CONTENTFUL_PAINT_MS$median))  {
              "FIRST_CONTENTFUL_PAINT_MS_median"
            },
            if (!is.null(x$loadingExperience$metrics$FIRST_CONTENTFUL_PAINT_MS$category))  {
              "FIRST_CONTENTFUL_PAINT_MS_category"
            },
            if (!is.null(x$loadingExperience$metrics$DOM_CONTENT_LOADED_EVENT_FIRED_MS$median))  {
              "DOM_CONTENT_LOADED_EVENT_FIRED_MS_median"
            },
            if (!is.null(x$loadingExperience$metrics$DOM_CONTENT_LOADED_EVENT_FIRED_MS$category))  {
              "DOM_CONTENT_LOADED_EVENT_FIRED_MS_category"
            },
            if (!is.null(x$loadingExperience$overall_category))  {
              "loadingExperience_overall_category"
            })
        return(ret)
      }

    }

  }
