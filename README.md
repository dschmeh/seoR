# seoR
[![Rdoc](https://www.r-pkg.org/badges/version/seoR)](https://cran.r-project.org/web/packages/seoR/index.html)
[![Build Status](https://travis-ci.org/dschmeh/seoR.svg?branch=master)](https://travis-ci.org/dschmeh/seoR)

The Package provides various functions to get informations relevant for SEO related analysis in R

The Goal of this package is to provide various functions to help SEOs retrive relevant informations from various APIs or Websites direct in R.
The Package is splitted in four parts: Scraping Data from Websites, scraping Data from Search Engines, getting Data from various SEO-APIs and working with data from a Screaming Frog Crawl. 
It´s possible to scrape SEO-relevant parts of a Website. So you are able to extract Links, Meta-Tags, H-Tags, and many more.
The package also provides functions to scrape informations form search engines. Like Indexed Pages, results for a given Keyword.
The third part of the Package are the SEO-Tool APIs, that are connected. It´s possible to get Informations from Whois, Google Pagespeed and many more direct in the R Console.


# Installation 
Install the current stable Version from CRAN:
```
install.packages("seoR")
```

To get the current development version from github:

```
# install.packages("devtools")
devtools::install_github("dschmeh/seoR")
```

# The HTML-Scraping Functions
The Package provides various Functions to retrieve Releveant informations from a given URL.

## Getting the HTML Title Tag of a URL in R
The HTMLtitle-Function allows to scrape the Title-Tag of a given URL
```
url<-"https://www.r-project.org/"
HTMLtitle(url)
```

## Getting the length of a Title Tag in R
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

## Getting the Meta-Description in R
The HTMLdescription-Function gives you the Meta-Description of a specified Url
```
url<-"https://www.r-project.org/"
HTMLdescription(url)
```

## Getting the Meta-Description length in R
The HTMLdescription_length-Function gives you the lenght of the Meta-Description, scraped from a specified Url
```
url<-"https://www.r-project.org/"
HTMLdescription_length(url)
```

## Getting the Meta-Robots in R
The HTMLrobots-Function provides you with the Meta-Robots of a given Url
```
url<-"https://www.r-project.org/"
HTMLrobots(url)
```

## H-Tags of a Website in R
The htag-Functions gives you a Data Frame with all H-Tags on a given URL. You just have to specify the H-Tag you want to get. As default you get H1.
```
url<-"https://www.r-project.org/"
htag(url, hTag = "h1")
```

The htag_count function gives you the number of H-Tags on the Page.
```
url<-"https://www.r-project.org/"
htag_count(url, hTag = "h3")
```

## Getting Canonical-Tags of a URL in R
The HTMLcanonical-Function retrieves the Canonical-Tags on a given Page.
```
url<-"https://www.r-project.org/"
HTMLcanonical(url)
```

## Getting hreflang-Tags 
The hrefLang-Function provides you with the hreflang-Tags on a URL as a Data Frame.
```
url<-"https://www.r-project.org/"
hrefLang(url)
```

## Getting Informations about Links on a Webpage in R
The seoR-Package contains Functions, that make it possible to retrieve Infromations about Links on a given Webpage. With the extractLinks-Function you get a Dataframe with all outgoing Links of a specific Url. You can choose If you want to have duplicated Links in this or not. Default you get duplicated ones.
```
url<-"https://www.r-project.org/"
extractLinks(url, uniqueLinks = FALSE)
```

The linkCount-Function allows you to get the number of all Links on a specified Url. You can specify the LinkType you want to analyze. All Links, Just Internal Links or Links to other Domains (external). You can specify "all","external" and "internal". Default is "all"
```
url<-"https://www.r-project.org/"
linkCount(url, linkType = "all", uniqueLinks = FALSE)
```

## Download a Sitemap in R
The downloadSitemap-Function provides a possibility to Download a XML-Sitemap to a Dataframe. You can specify one Sitemap you want to Download or a Index-Sitemap.
```
sitemap<-"http://ohren-reinigen.de/sitemap.xml"
downloadSitemap(sitemap)
```

## Check for an URL in a XML-Sitemap
Check if a given URL is found in a XML-Sitemap. For this you can also put in your Index-Sitemap.
```
url<-"https://www.r-bloggers.com/combining-faa-and-stepwise-correlation/"
sitemap<-"https://www.r-bloggers.com/sitemap.xml"
urlInSitemap(url, sitemap)
```

# Scraping Search Engines in R
Beside scraping Data from Websites you can also scrape Data from various Searchengines.

## Number of results for a Keyword
The keywordResults-Function gives you the number of Search Engine Results for a given Keyword. Here you can specify which Searchengine you want to use as Source. Default is Google.

```
keyword<-"R Project"
keywordResults(keyword, searchengine = "google")
```

## Get Google suggestions for a Keyword
The googleSuggest-Function returns relevant longtail keywords for a specific Keyword. The function uses the Google Autocomplete functionality. You can specify the language in the call, default is "en". walkThrough is a logical input to add every letter of the alphabet before and after the keyword to get more related keywords.

```
keyword<-"R Project"
googleSuggest(keyword, language = "en", walkThrough = FALSE)
```

## Number of Pages in Index
The pagesInIndex-function allows you to perform a "site"-Search on Google to get the number of PAges in the Index for a given Domain or URL-String.

```
url<-"https://www.r-project.org/"
pagesInIndex(url)
```

## Retrieve the last Cached Data for a URL
The lastCached-Function allows you to get the last Cached Date from Google.
```
url<-"https://www.r-project.org/"
lastCached(url)
```

## Check if a URL is blocked by robots.txt
The allowedByRobots-Function checks if a given URL is blocked by the robots.txt-File. It´s possible to specify the bot, for example "googlebot", to check if this bot is blocked.
```
url<-"https://www.r-project.org/"
allowedByRobots(url, bot = "googlebot")
```

## Check if a URL is indexable
The isIndexable-Functions checks if a given URL can be indexed by a Searchengine. Therefor the Function runs various test, on the Status Code, the Canonical Link element, the Meta-Robots and the robots.txt. The errorType specifys if just TRUE/FALSE is returned or also the reason why the URL can´t be indexed. 
```
url<-"https://www.r-project.org/"
isIndexable(url, bot = "googlebot", errorType = TRUE)
```

## Scraping Bing Search Results in R
The function allows you to get the search results from Bing. The Function extratcts just the organic Search results. the Output is a Dataframe containing, Title,Description, URL and Landing Page.
```
getBingResults("R Project")
```

## Getting Traffic of a given Wikipedia Article
(Not on CRAN) This function allows to get the pageviews for a given Wikiepdia article.
```
wikipediaTraffic("R (programming language)",'2018-01-01','2018-01-10')
```

# Third-Party Tools and APIs
We want to add more and more third party Tools and SEO-APIs to this Package. So if you have a ready Code or just a idea what could be missing, just ping us.

## W3C-Validate in R
The w3cValidate-Function allows you to start and get the results of a w3c-Validation for a given URL. You get a Dataframe with the Errors and Warnings from the Report.
```
url<-"https://www.r-project.org/"
w3cValidate(url)
```

## Getting the Domain-Age in R
The domainAge-Function gives you the Age of a given Domain (Attention: At the Moment we just can retrieve the Data from .com-Domains)
```
url<-"https://amazon.com"
domainAge(url)
```

## Google Mobile Friendly testing API in R
The mobileFriendly-Function provides you an API-Access to the Mobile Friendly Testing API from Google. You will get a TRUE or FALSE for a given Url you want to test. This Google API is still in Beta and quite slow. You also will get 502-Errors quite often. You can find more information about this API her: https://developers.google.com/webmaster-tools/search-console-api/about
```
url<-"https://www.r-project.org/"
mobileFriendly(url)
```

## Google Pagespeed-API R
The pageSpeed-Function allows you to retrieve Data from Googles Pagespeed API (v4 Versions). You will get a Value between 0 and 100 for each tested Url. You can find more information about the API her: https://developers.google.com/speed/docs/insights/v4/getting-started
```
url<-"https://www.r-project.org/"
pageSpeed(url)
```

## Moz API in R
The packages provides functions to retrieve Data from the Moz-API. To use this functions you need to get a Moz-API-Key. This Key is for free. More Informations and how to get it can be found here: https://moz.com/help/guides/moz-api/mozscape/getting-started-with-mozscape/create-and-manage-your-account

### Moz URL Metrics in R
The mozUrlMetrics-function allows you to get various Informations about a specific URL. You can find more Informations about the API and the provided Data here:https://moz.com/help/guides/moz-api/mozscape/api-reference/url-metrics At the Moment you just get the Data provided by a free Account.
```
page<-"https://www.r-project.org/"
Access_ID<-{{YOUR_ACCESS_ID}}
Secret_Key<-{{YOUR_SECRET_KEY}}
mozUrlMetrics(page, Access_ID, Secret_Key)
```

### Moz Link Metrics in R
The mozLinkMetrics-function allows you to get various Informations about the Backlinks of a specific URL/Domain. You can find more Informations about the API and the provided Data here:https://moz.com/help/guides/moz-api/mozscape/api-reference/link-metrics At the Moment you just get the Data provided by a free Account.
To Use the API you can specify the following Parameters:
* page The page you want the data for (Requiered)
* Access_ID Your Moz Access ID (Requiered)
* Secret_Key Your Moz Secret Key (Requiered)
* Scope indicates which links to return based on whether the target and source URLs are pages, domains, or subdomains.
* Limit The default value of Limit is 1 and the maximum value is 50.
* Filter  excludes results unless they meet criteria you specify. You can specify more than one value by separating multiple Filter parameters with a plus symbol +.
* Sort Sort links results by:https://moz.com/help/guides/moz-api/mozscape/api-reference/link-metrics
* SourceCols is a bit flag: a numerical value specifying which data to include about source URLs that link to the target URL.
* TargetCols  is a bit flag: a numerical value specifying which data to include about the target URL.
* LinkCols is a bit flag: a numerical value specifying which data to include about the link itself (for example, if the link is nofollowed).
```
page<-"https://www.r-project.org/"
Access_ID<-{{YOUR_ACCESS_ID}}
Secret_Key<-{{YOUR_SECRET_KEY}}
mozLinkMetrics(page, Access_ID, Secret_Key, Scope = "page_to_page", Limit = 1, Filter = "",Sort = "",SourceCols = "536870916",TargetCols = "536870916", LinkCols = "")
```

## Seo Diver API
This function allows you to get Data from the SEO Diver API. http://de.seodiver.com/api Note: This Data is only available for DE,CH,AT Search Results. You get "Suchreichweite", "Suchwahrnehmung" and "Statische Sichtbarkeit"
```
url<-"r-project.org"
seoDiver(url, type = "Suchreichweite")
```

## Social Shares for a URL via sharedcount.com-API
This function allows to get the shares of a given Domain into R. Therefore the function uses the Sharedcount-API. To use the function you have to set up a free API-Account here: https://www.sharedcount.com/
```
url<-"https://www.r-project.org/"
key<-{{YOUR_API_KEY}}
sharedcount(url, key)
```

# Screaming Frog Data in R
Various Functions to work with data from a Screaming Frog Crawl in R.

## Compare a Screaming Frog Crawl with URLs in a Sitemap.xml
The screamingfrog_crawlVsSitemap-Functions provides a possibility to compare data from a Screaming Frog Crawl with the URLs in a sitemap.xml. It´s possible to find deltas in both data sources. 

```
crawl<-"C:/Users/User/Downloads/internal_all.csv"
sitemap<-"http://ohren-reinigen.de/sitemap.xml"
screamingfrog_crawlVsSitemap(crawl, sitemap, deltaIn = "sitemap", checkImages = FALSE)
```

## Computating internal Pagerank in R
The screamingfrog_internalPagerank-Function provides a possibility to computate the internal Pagerank based on a Screaming Frog Crawl. For the function you need to Download the "all_outlinks.csv"-File from the crawl you want to analyze.

```
crawl<-"C:/Users/User/Downloads/all_outlinks.csv"
screamingfrog_internalPagerank(crawl, domain = NULL)
```

# Contributing
If you found a bug or want to propose a feature, feel free to visit the issues page. You can also write me a mail: danielschmeh@gmail.com
