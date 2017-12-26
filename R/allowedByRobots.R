#' Function to check if URL is blocked by robots.txt
#'
#' This function checks if a given URL is blocked by the robots.txt file of the website.
#' @url The url you want to check
#' @bot The bot you want to check the indexability with. Default is googlebot
#' allowedByRobots()

allowedByRobots <- function(url, bot = "googlebot") {
  require(robotstxt)
  domain <-
    stringr::str_extract(
      url,
      "http(s)?\\:\\/\\/([a-zA-Z0-9-]*\\.)?[a-zA-Z0-9-]*\\.[a-zA-Z0-9]{2,3}(\\.[a-zA-Z0-9]{2,3})?"
    )
  per <-
    robotstxt::paths_allowed(paths = url,
                             domain = domain,
                             bot = bot)
  return(per)
}
