#' Function to calculate the internal PageRank of a crawled Page
#'
#' This function allows you to calculate the internal PageRank of a given Domain. The calculation is based on a ScreamingFrog Crawl and the export "all_outlinks.csv".
#' @crawl The Path to your "all_outlinks.csv"-File
#' @domain The function also analyzes outgoing links. If you want the results just for your domain. Specify it here.
#' screamingfrog_internalPagerank()

screamingfrog_internalPagerank <- function(crawl, domain = NULL) {
  sc_crawl <- read.csv(crawl, skip = 1)
  sc_crawl <- subset(sc_crawl, Type == "AHREF")
  sc_crawl <- subset(sc_crawl, Follow == "true")
  sc_crawl <-
    igraph::graph.data.frame(cbind(
      as.character(sc_crawl$Source),
      as.character(sc_crawl$Destination)
    ))
  sc_pr <- igraph::page.rank(sc_crawl, "prpack", vids = V(sc_crawl))
  sc_pr <- as.data.frame(sc_pr$vector)
  sc_pr$URL <- rownames(sc_pr)
  row.names(sc_pr) <- NULL
  colnames(sc_pr)[1] <- "PageRank"
  sc_pr <- sc_pr[c(2, 1)]
  if(is.null(domain)){
  return(sc_pr)} else {
    sc_pr <- sc_pr[grep(domain, sc_pr$URL), ]
  }
}
