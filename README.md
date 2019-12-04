
# hw09 Kejing Li

## Introduction

This assignment focus on the text analysis, especially the sentiment analysis of the Disney film Frozen II. 

* The data is obtained by scraping([find code here](scrape.R)) three major English review websites: Rotten Tomatoes, IMDb(Internet MovieDatabase) and Metacritic. 

* To enhance the reproducibility, I compiled the scraped data into a csv file and saved it into the [data file](data/review.csv).

* The output can be viewed [here](frozen2_review.Rmd).

## Required packages

The following packages are needed for reproducing the work:

```r
library(tidyverse)
library(tm)
library(here)
library(tidytext)
library(knitr)
library(kableExtra)
library(scales)
library(textdata)
library(reshape2)
library(wordcloud)
```


