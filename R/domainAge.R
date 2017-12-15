#' Function to retrieve the Age of a given Domain
#'
#' This function allows you to get the Do´main Age for a given Domain. (Attention:At the moment just possible with .com-Domains)
#' @domain The domain you want to get the age for.
#' domainAge()



domainAge <- function(domain) {
  url <- gsub("http://|https://", "", domain)
  age <-
    jsonlite::fromJSON(
      paste0(
        'http://api.bulkwhoisapi.com/whoisAPI.php?domain=',
        url,
        '&token=usemeforfree'
      )
    )
  if (age$response_code == "success") {
    age <- as.Date(age$formatted_data$CreationDate)
  } else {
    if (is.na(stringr::str_extract(url, ".com"))) {
      age <-
        "No Data - Warning: At the moment we can just retrieve data from .com-Domains"
    } else {
      age <- "No Data"
    }
  }
  return(age)
}
