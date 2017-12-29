#' Function to compare the crawled URLs with the URLs in the sitemap.xml
#'
#' This function allows to compare the crawled URLs with the URLs in the sitemap.xml. The Output are the missing URLs - in the Sitemap or in the Crawl
#' @crawl The Path to the exportet Screaming Frog csv-File
#' @sitemap The Sitemap you want to compare with the Crawl
#' @deltaIn The Delta you want to analyze. Do you want to get the URLs in the Crawl missing in the Sitemap = "crawl" or the URLs in the Sitemap.xml not found in the Crawl = "sitemap"
#' @checkImages Logical. Do you want to check the Images as well. Default is FALSE.
#' screamingfrog_crawlVsSitemap()


screamingfrog_crawlVsSitemap <-
  function(crawl,
           sitemap,
           deltaIn = "sitemap",
           checkImages = FALSE) {
    #Import the Screaming Frog Crawl data
    sc_crawl <- readr::read_csv(crawl, skip = 1)

    #Check if it´s the correct File
    if (isTRUE(internal_all_file(sc_crawl))) {

    } else {
      stop(
        "Please make sure, that the File you provide is a not modified export from Screaming Frog"
      )
    }

    crawled_pages <-
      as.data.frame(cbind(sc_crawl$Address, sc_crawl$Content)) # Just HTML-Pages
    colnames(crawled_pages)[1] <- "loc"
    #Just keep HTML
    if (checkImages == FALSE) {
      #Just keep HTML
      crawled_pages <-
        subset(crawled_pages, V2 == "text/html; charset=UTF-8")
    } else {
      #Keep HTML and Images
      crawled_pages <-
        subset(
          crawled_pages,
          V2 == "text/html; charset=UTF-8" |
            V2 == "image/png" | V2 == "image/jpeg"
        )
    }

    #Download the Sitemap.xml
    sm <- downloadSitemap(sitemap)
    sm <- as.data.frame(sm$loc)
    colnames(sm)[1] <- "loc"

    if (deltaIn == "sitemap") {
      res <- dplyr::anti_join(sm, crawled_pages, by = "loc")
      colnames(res)[1] <- "In_Sitemap_not_in_Crawl"
    } else {
      res <- dplyr::anti_join(crawled_pages, sm, by = "loc")
      res <- as.data.frame(res$loc)
      colnames(res)[1] <- "In_Crawl_not_in_Sitemap"
    }
    return(res)

  }
