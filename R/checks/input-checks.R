#Functions to check the input

#URL Input checks

##Check if the User provided a correct URL with Protocoll
url_with_http <- function(url) {
  return(
    grepl(
      "^http(s)?\\:\\/\\/([a-zA-Z0-9-]*\\.)?[a-zA-Z0-9-]*\\.[a-zA-Z]{2,3}(\\.[a-zA-Z]{2,3})?",
      url
    )
  )
}

##Check if the User just provided the Hostname and TLD
host_tld <- function(url) {
  return(grepl("^[a-zA-Z0-9-]*\\.[a-zA-Z]{2,3}(\\.[a-zA-Z]{2,3})?", url))
}

#Check if the User provided a correct Sitemap.xml
sitemapxml_check<-function(sitemap){
  return(grepl("^http(s)?\\:\\/\\/.*xml$", sitemap))
}

#Other Input checks

##Check h-Tag Input
htag_input <- function(h_tag) {
  return(grepl("^h[1-6]{1}", h_tag))
}

##Check general choices
choice <- function(choice, possible = "") {
  regex <- paste0("^(", possible, ")$")
  return(grepl(regex, choice))
}

#Check Screaming-Frog Input Files
internal_all_file <- function(input) {
  if (ncol(input) != 41) {
FALSE
  } else {
    TRUE
  }
}
