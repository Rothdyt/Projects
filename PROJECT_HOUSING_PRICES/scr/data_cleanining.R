# creating the training data set
## rule 1: If nobody rent a given house, then this house will be kicked out.
## rule 2: If a given house is always not avaliable, then this house will be kicked out.
## rule 3: If the price range of a given house is too large, then it will be kicked out.

# Known problems with data set: calendar.csv
# 1. price is char, and symbols "," and "$" in each entry will pollute our data
# 2. wrong records. For example, house[listing_id: 447826] get one day's price 7163, 
#    which is obvious a wrong record.


calendar <- read.csv("./data/calendar.csv")
house_ids <- unique(calendar$listing_id)
calendar_selected <- matrix(NA,ncol=4,nrow=0)
# for (id in house_ids){
#   house <- calendar[calendar$listing_id == id,]
#   n <- dim(house)[1]
#   condition1 <- sum(house$available == "f") < n
#   condition2 <- sum(house$available == "f") > 1
#   if (condition1 & condition2){
#     calendar_selected <- rbind(calendar_selected,house)
#   }
# }
# save(calendar_selected ,file = "./data/calendar_selected.Rdata")

rm(list=ls())
library(dplyr)
load("./data/calendar_selected.Rdata")
calendar_selected$price <- gsub('[$,]', '', calendar_selected$price)
calendar_selected$price <- as.numeric(calendar_selected$price)
calendar_mean <- calendar_selected %>%
  group_by(calendar_selected$listing_id) %>%
  summarise(ave_price=mean(price,na.rm=T),
            price_range=range(price,na.rm=T)[2]-range(price,na.rm=T)[1])
save(calendar_mean ,file = "./data/calendar_mean.Rdata")
write.csv(calendar_mean ,file = "./data/calendar_mean.csv")

rm(list=ls())
load("./data/calendar_mean.Rdata")
reference <- calendar_mean$`calendar_selected$listing_id`
listings <- read.csv("./data/listings.csv")
rule <- listings$id %in% reference
listings_selected <- listings[rule,]
listings_selected <- listings_selected[order(listings_selected$id),]
names(calendar_mean)[1] <- "id"
fulldataset <- inner_join(calendar_mean, listings_selected, by = "id")

save(fulldataset ,file = "./data/fulldataset.Rdata")
write.csv(fulldataset ,file = "./data/fulldataset.csv")
