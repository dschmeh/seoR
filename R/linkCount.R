#' Function to retrive the number of outgoing links for a given Url.
#'
#' This function allows you to get the number of outgoing links for a given URL.You can specify if you want to count same Links as one or not.
#' @param url The url you want to get the number of outgoing links for
#' @param linkType The LinkType you want to analyze. All Links, Just Internal Links or Links to other Domains (external). You can specify "all","external" and "internal". Default is "all"
#' @param uniqueLinks Logical. Count unique Links as one is TRUE. Default is FALSE
#' linkCount()
#' @examples
#' linkCount("https://www.r-project.org/", linkType = "all", uniqueLinks = FALSE)



linkCount <- function(url,
                      linkType = "all",
                      uniqueLinks = FALSE) {

  domain <-
    stringr::str_extract(
      url,
      "http(s)?\\:\\/\\/([a-zA-Z0-9-]*\\.)?[a-zA-Z0-9-]*\\.[a-zA-Z0-9]{2,3}(\\.[a-zA-Z0-9]{2,3})?"
    )
  links <- try(as.data.frame(url %>%
                               as.character() %>%
                               read_html() %>%
                               html_nodes("a") %>%
                               html_attr("href")))
  colnames(links)[1] <- "links"
  if (uniqueLinks == FALSE)	{
    #Starting with not uniue Links
    if (linkType == "external") {
      return(nrow(links) - (length(grepl(
        domain, links$links
      )[grepl(domain, links$links) == TRUE]) + length(grepl(
        "^\\/.*", links$links
      )[grepl("^\\/.*", links$links) == TRUE])))
    } else {
      if (linkType == "internal") {
        return (length(grepl(domain, links$links)[grepl(domain, links$links) == TRUE]) +
                  length(grepl("^\\/.*", links$links)[grepl("^\\/.*", links$links) == TRUE]))
      } else {
        return(nrow(links))
      }
    }
  } else {
    if (linkType == "external") {
      return(nrow(unique(links)) - (length(grepl(
        domain, links$links
      )[grepl(domain, unique(links$links)) == TRUE]) + length(grepl(
        "^\\/.*", unique(links$links)
      )[grepl("^\\/.*", links$links) == TRUE])))
    } else {
      if (linkType == "internal") {
        return(length(grepl(domain, links$links)[grepl(domain, unique(links$links)) == TRUE]) +
                 length(grepl("^\\/.*", unique(
                   links$links
                 ))[grepl("^\\/.*", links$links) == TRUE]))
      } else {
        return(nrow(unique(links)))
      }
    }
  }

}
