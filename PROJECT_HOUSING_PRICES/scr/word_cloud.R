# Install
# install.packages("tm")  # for text mining
# install.packages("SnowballC") # for text stemming
# install.packages("wordcloud") # word-cloud generator 
# install.packages("RColorBrewer") # color palettes
# Load
library("tm")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")

# Read the text file from internet
filePath <- "http://www.sthda.com/sthda/RDoc/example-files/martin-luther-king-i-have-a-dream-speech.txt"
text <- readLines(filePath)
# Load the data as a corpus
docs <- Corpus(VectorSource(text))
inspect(docs)
# deal with special characters
toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
docs <- tm_map(docs, toSpace, "/")
docs <- tm_map(docs, toSpace, "@")
docs <- tm_map(docs, toSpace, "\\|")
inspect(docs)
# cleaning the text
## stop-words
docs <- tm_map(docs, removeWords, stopwords("english"))
# term-documnet matrix
dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 10)
set.seed(1234)
wordcloud(words = d$word, freq = d$freq, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))

rm(list=ls())
load("./data/selected_houses_id.Rdata")
# step 1: pool comments for each selected house
reviews <- read.csv("./data/reviews.csv")
rule <- reviews$listing_id %in% selected_houses_id
reviews_selected <- reviews[rule,]
reviews_selected <- reviews_selected[order(reviews_selected$listing_id),]
# delete "id","date","reviewer_id","reviewer_name"
reviews_selected <- reviews_selected[,c(1,6)]
reviews_selected$comments <- as.character(reviews_selected$comments)
reviews_simplified <- reviews_selected
# save(reviews_simplified,file="./Shinyapp/reviews.Rdata")
# z <- reviews[reviews$listing_id == "1365335",]
# as.character(z$comments)

# Load the data as a corpus
selected_id <- which(reviews_simplified$listing_id == "6695")
docs <- Corpus(VectorSource(reviews_simplified[selected_id,]$comments))
inspect(docs)
# deal with special characters
toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
docs <- tm_map(docs, toSpace, "\n")
docs <- tm_map(docs, tolower)
# cleaning the text
## stop-words
docs <- tm_map(docs, removeWords, stopwords("english"))
docs <- tm_map(docs, removeWords, stopwords("spanish"))
docs <- tm_map(docs, removeWords, stopwords("french"))
docs <- tm_map(docs, removeWords, c("the","boston"))
# term-documnet matrix
dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 10)
set.seed(1234)
wordcloud(words = d$word, freq = d$freq, min.freq = 1,
          max.words=50, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))
