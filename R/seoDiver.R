#' Function to retrive data from the SEO Diver API
#'
#' This function allows you to get Data from the SEO Diver API. http://de.seodiver.com/api Note: This Data is only available for DE,CH,AT Search Results. You get "Suchreichweite", "Suchwahrnehmung" and "Statische Sichtbarkeit"
#' @param url The URL you want to get the Data for
#' @param type The type of Data you want to get. Possible Inputs are: "Suchreichweite", "Suchwahrnehmung" and "Statische Sichtbarkeit"
#' seoDiver()

seoDiver <- function(url, type = "Suchreichweite") {
  url <- gsub("https://|http://", "", url)
  if (type == "Suchreichweite") {
    out <-
      jsonlite::fromJSON(paste0(
        "http://public.seodiver.com/d.api?d=sr&url=",
        url,
        "&format=json"
      ))
    out <- as.character(out$value)
  } else {
    if (type == "Suchwahrnehmung") {
      out <-
        jsonlite::fromJSON(paste0(
          "http://public.seodiver.com/d.api?d=sp&url=",
          url,
          "&format=json"
        ))
      out <- as.character(out$value)
    } else {
      if (type == "Statische Sichtbarkeit") {
        out <-
          jsonlite::fromJSON(
            paste0(
              "http://public.seodiver.com/d.api?d=sv&url=",
              url,
              "&format=json"
            )
          )
        out <- as.character(out$value)
      } else {
        warning(
          "Please check your type Input. Type not found. Check the API-Doku:http://de.seodiver.com/api"
        )
      }
    }
  }
  return(out)
}
