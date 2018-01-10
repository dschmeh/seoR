#' Function to check if a URL is indexable
#'
#' This function checks if a given URL is indexable. Therfore it checks different rules:
#' Status-Code: Does the URl gives a correct Status-Code (200)
#' Canonical-Link: Is the canonical Link Element implementet, so the URL can be indexed?
#' Meta-Robots: Is the Meta-Robots blocking the ULR?
#' robots.txt: Is the robots.txt blocking the URL from crawling?
#' @param url The url you want to check the indexability for
#' @param bot The bot you want to check the indexability with. Default is googlebot
#' @param errorType Logical. Retrieves the Error, why the URL can´t be indexed. Attention not all rules at once are displayed.
#' isIndexable()
#' @examples
#' isIndexable("https://www.r-project.org/", bot = "googlebot", errorType = TRUE)

isIndexable <- function(url,
                        bot = "googlebot",
                        errorType = TRUE) {
  if (responseCode(url) != 200) {
    if (errorType == TRUE) {
      return(paste0("Response-Code: ", responseCode(url)))
    } else {
      return(FALSE)
    }
  } else {
    if (HTMLcanonical(url) == url |
        HTMLcanonical(url) == "No Canonical-Tag") {
      if (isTRUE(grepl("noindex", HTMLrobots(url)))) {
        if (errorType == TRUE) {
          return("Meta Robots Problem")
        } else  {
          return(FALSE)
        }
      } else {
        if (isTRUE(allowedByRobots(url, bot = bot))) {
          return(TRUE)
        } else {
          if (errorType == TRUE) {
            return("Blocked by robots.txt")
          } else {
            return(FALSE)
          }
        }
      }
    } else {
      if (errorType == TRUE) {
        return("Canonical Problem")
      } else {
        return(FALSE)
      }
    }
  }
}
