library(rvest)
library(here)

#scrape comments from rotten tomatoes
tomato_reviews <- tibble()
#there are 13 pages in total 
for (i in 1:13) {
  url = paste("https://www.rottentomatoes.com/m/frozen_ii/reviews?type=&sort=&page=","i",sep="")
#extract review text
  tomato_text <-read_html(url)%>%
    html_nodes(".the_review")%>%
    html_text()%>%
    as.tibble()
#put the review text into a dataframe
  tomato_reviews <- bind_rows(tomato_reviews,tomato_text) 
}
#create a conlumn identify the review source
tomato_reviews <- tomato_reviews %>%
  mutate(site = "rotten_tomatoes",
         reviews = value)%>%
  select(-value)



#scrape comments from imdb
imdb_reviews <- tibble()
imdb_text <- read_html("https://www.imdb.com/title/tt4520988/reviews?sort=submissionDate&dir=desc&ratingFilter=0")%>%
    html_nodes(".text")%>%
    html_text()%>%
    as.tibble()

imdb_reviews <- bind_rows(imdb_reviews,imdb_text) 

imdb_reviews <- imdb_reviews %>%
  mutate(site = "imdb",
         reviews = value)%>%
  select(-value)


#scrape comments from Metacritic
meta_reviews <- tibble()
meta_text <- read_html("https://www.metacritic.com/movie/frozen-ii/critic-reviews")%>%
  html_nodes(".no_hover")%>%
  html_text()%>%
  as.tibble()
#put the review text into a dataframe
meta_reviews <- bind_rows(meta_reviews,meta_text) 

#create a conlumn identify the review source
meta_reviews <- meta_reviews %>%
  mutate(site = "metacritic",
         reviews = value)%>%
  select(-value)

# remove blank before character
meta_reviews$reviews <- gsub("\n                                                ", "", meta_reviews$reviews)
tomato_reviews$reviews <- gsub("\n                                    ", "", tomato_reviews$reviews)
imdb_reviews$reviews <- gsub("\n                       ", "", imdb_reviews$reviews)

#combine the dataset
all_reviews <- bind_rows(meta_reviews, tomato_reviews, imdb_reviews)


#save it to the folder
all_reviews%>%
write_csv(here("data", "reviews.csv"))
