#' Function to retrive the hrefLang-Tag for a given URL
#'
#' This function allows you to get the hrefLang-Tags for a given URL. You get the Output as a Data Frame containing the Link and the Country/Language specififcation.
#' @param url The URL you want to get the hrefLang-Tag for
#' hrefLang()
#' @examples
#' hrefLang("https://www.r-project.org/")


hrefLang <- function(url) {

  lang <- try(url %>%
                as.character() %>%
                xml2::read_html() %>%
                stringr::str_extract_all("(.href\\=..*. hreflang\\=..*.| hreflang\\=..*..href\\=..*.)"))
  if (nrow(as.data.frame(unlist(lang))) == 0) {
    return("No hrefLang-Tag")
  } else {
    lang <-
      t(as.data.frame((
        stringr::str_split(unlist(lang), "( hreflang=| href=)")
      )))
    lang <- gsub(">", "", lang)
    lang <- gsub("href=", "", lang)
    if (is.na(stringr::str_extract(lang[1, 2], "http")))
    {
      lang <- cbind(lang[, 3], lang[, 2])
      colnames(lang) <- c("URL", "Country")
    } else {
      lang <- cbind(lang[, 2], lang[, 3])
      colnames(lang) <- c("URL", "Country")
    }
    rownames(lang) <- c(1:nrow(lang))
    return(lang)
  }
}
