#' Function to extract all links of a given Url.
#'
#' This function allows you to extract all links of a given URL. You can specify if you just want unique Links or all. The output is a Data Frame.
#' @url The url you want to extract the Links of
#' @linkType The LinkType you want to analyze. All Links, Just Internal Links or Links to other Domains (external). You can specify "all","external" and "internal". Default is "all"
#' @uniqueLinks Logical. Extract unique Links as one is TRUE. Default is FALSE
#' extractLinks()



extractLinks <-
  function(url,
           linkType = 'all',
           uniqueLinks = FALSE) {
    requireNamespace(magrittr)
    requireNamespace(rvest)
    requireNamespace(stringr)

    domain <-
      stringr::str_extract(
        url,
        "http(s)?\\:\\/\\/([a-zA-Z0-9-]*\\.)?[a-zA-Z0-9-]*\\.[a-zA-Z0-9]{2,3}(\\.[a-zA-Z0-9]{2,3})?"
      )
    check <- paste0("(", domain, "|^\\/.*)")


    links <- try(as.data.frame(url %>%
                                 as.character() %>%
                                 read_html() %>%
                                 html_nodes("a") %>%
                                 html_attr("href")))
    colnames(links)[1] <- "links"
    if (uniqueLinks == FALSE)	{
      if (linkType == 'internal') {
        links$check <- as.data.frame(grepl(check, links$links))
        links <- subset(links, check == TRUE)
        return(as.data.frame((links$links)))
      } else {
        if (linkType == 'external') {
          links$check <- as.data.frame(grepl(check, links$links))
          links <- subset(links, check == FALSE)
          return(as.data.frame((links$links)))
        } else {
          return(links)
        }
      }
    } else {
      if (linkType == 'internal') {
        links$check <- as.data.frame(grepl(check, links$links))
        links <- subset(links, check == TRUE)
        return(as.data.frame(unique(links$links)))
      } else {
        if (linkType == 'external') {
          links$check <- as.data.frame(grepl(check, links$links))
          links <- subset(links, check == FALSE)
          return(as.data.frame(unique(links$links)))
        } else {
          return(unique(links))
        }
      }
    }
  }
