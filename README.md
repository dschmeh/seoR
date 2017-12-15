# seoR
The Package provides various functions to get informations relevant for SEO related analysis in R

The Goal of this package is to provide various functions to help SEOs retrive relevant informations from various APIs or Websites direct in R.
The Package is splitted in three parts: Scraping Data from Websites, scraping Data from Search Engines and getting Data from various SEO-APIs. 
It´s possible to scrape SEO-relevant parts of a Website. So you are able to extract Links, Meta-Tags, H-Tags, and many more.
The package also provides functions to scrape informations form search engines. Like Indexed Pages, results for a given Keyword.
The third part of the Package are the SEO-Tool APIs, that are connected. It´s possible to get Informations from Whois, Google Pagespeed and many more direct in the R Console.


# Installation 
To get the current development version from github:

```
# install.packages("devtools")
devtools::install_github("dschmeh/seoR")
```

# The HTML-Scarping Functions
The Package provides various Functions to retrieve Releveant informations from a given URL.

## Getting the HTML Title Tag of a URL in R
The HTMLtitle-Function allows to scrape the Title-Tag of a given URL
```
url<-"https://www.r-project.org/"
HTMLtitle(url)
```

## Getting the length of a Title Tag in README
The HTMLtitle_length-Function gives you the lenght of the Title Tage, scraped from a specified Url
```
url<-"https://www.r-project.org/"
HTMLtitle_length(url)
```

## Getting the http Status Code of a URL in R
The responseCode-Function gives you the response Code of a specified Url
```
url<-"https://www.r-project.org/"
responseCode(url)
```

# Getting the Meta-Description in R
The HTMLdescription-Function gives you the Meta-Description of a specified Url
```
url<-"https://www.r-project.org/"
HTMLdescription(url)
```

# Getting the Meta-Description length in R
The HTMLdescription_length-Function gives you the lenght of the Meta-Description, scraped from a specified Url
```
url<-"https://www.r-project.org/"
HTMLdescription_length(url)
```

#Getting the Meta-Robots in R
The HTMLrobots-Function provides you with the Meta-Robots of a given Url
```
url<-"https://www.r-project.org/"
HTMLrobots(url)
```

#H-Tags of a Website in R
The htag-Functions gives you a Data Frame with all H-Tags on a give n URL. You just have to specify the H-Tag you want to get. As default you get H1.
```
url<-"https://www.r-project.org/"
htag(url, hTag = "h1")
```

The htag_count function gives you the number of H-Tags on the Page.
```
url<-"https://www.r-project.org/"
htag_count(url, hTag = "h3")
```

#Getting Canonical-Tags of a URL in R
The HTMLcanonical-Function retrieves the Canonical-Tags on a given Page.
```
url<-"https://www.r-project.org/"
HTMLcanonical(url)
```

#Getting hreflang-Tags 
The hrefLang-Function provides you with the hreflang-Tags on a URL as a Data Frame.
```
url<-"https://www.r-project.org/"
hrefLang(url)
```

#Getting Informations about Links on a Webpage in R
The seoR-Package contains Functions, that make it possible to retrieve Infromations about Links on a given Webpage. With the extractLinks-Function you get a Dataframe with all outgoing Links of a specific Url. You can choose If you want to have duplicated Links in this or not. Default you get duplicated ones.
```
url<-"https://www.r-project.org/"
extractLinks(url, uniqueLinks = FALSE)
```

The linkCount-Function allows you to get the number of all Links on a specified Url.
```
url<-"https://www.r-project.org/"
linkCount(url, uniqueLinks = FALSE)
```

#Scraping Search Engines in R
Beside scraping Data from Websites you can also scrape Data from various Searchengines.

#Number of results for a Keyword
The keywordResults-Function gives you the number of Search Engine Results for a given Keyword. Here you can specify which Searchengine you want to use as Source. Default is Google.

```
keyword<-"R Project"
keywordResults(keyword, searchengine = "google")
```

#Number of Pages in Index
The pagesInIndex-function allows you to perform a "site"-Search on Google to get the number of PAges in the Index for a given Domain or URL-String.

```
url<-"https://www.r-project.org/"
pagesInIndex(url)
```

#Retrieve the last Cached Data for a URL
The lastCached-Function allows you to get the last Cached Date from Google.
```
url<-"https://www.r-project.org/"
lastCached(url)
```

#Third-Party Tools and APIs
We want to add more and more third party Tools and SEO-APIs to this Package. So if you have a ready Code or just a idea what could be missing, just ping us.

#W3C-Validate in R
The w3c_validate-Function allows you to start and get the results of a w3c-Validation for a given URL. You get a Dataframe with the Errors and Warnings from the Report.
```
url<-"https://www.r-project.org/"
w3c_validate(url)
```

#Getting the Domain-Age in R
The domainAge-Function gives you the Age of a given Domain (Attention: At the Moment we just can retrieve the Data from .com-Domains)
```
url<-"https://amazon.com
domainAge(url)
```

#Google Mobile Friendly testing API in R
The mobileFriendly-Function provides you an API-Access to the Mobile Friendly Testing API from Google. You will get a TRUE or FALSE for a given Url you want to test. This Google API is still in Beta and quite slow. You also will get 502-Errors quite often.
```
url<-"https://www.r-project.org/"
mobileFriendly(url)
```

#Google Pagespeed-API R
The pageSpeed-Function allows you to retrieve Data from Googles Pagespeed API. You will get a Value between 0 and 100 for each tested Url. 
```
url<-"https://www.r-project.org/"
pageSpeed(url)
```

