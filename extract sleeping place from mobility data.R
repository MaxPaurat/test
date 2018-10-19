
# only ever access things by name/user_id from now on 

# The row and user_id are not the same!!!!!!
# (some user_id's are skipped)

#extract sleeping place from mobility data
#install.packages("dplyr")
library(dplyr)
#library(data.table)
library(tibble)
# for first two week space -> extend for other two week periods!

#SET2_P01 <- read.csv("Data/Challenge Data/SET2/SET2_P01.CSV", header=FALSE)
#SET2_P01small <- read.csv("Data/Challenge Data/SET2/SET2_P01small.CSV", header=FALSE)

data = SET2_P01small
#data = SET2_P01

# row is user_id
sleepplace = as.tibble(matrix(nrow=NROW(unique(data$V1)), ncol = 25))
sleepplace = add_column(sleepplace, user_id = unique(data$V1), .before = "V1")

# creating datetime and date collumns
x= as.character(data$V2)
data$V2 = as.POSIXct(x, format = "%Y-%m-%d %H:%M:%S", tz = "GMT")
data$date = as.Date(data$V2)

# convert dates to integers in new collumn
date.lookup <- format(seq(as.Date("2013-01-07"), as.Date("2013-01-20"), by = "1 day")) 
data$int_date = match(as.character(data$date), date.lookup)



data_df = tbl_df(data)


colnames(data_df) = c("user_id", "timestamp", "site_id", "date", "int_date")
data_df_grouped = group_by(data_df, user_id, int_date)

sleep = summarize(data_df_grouped, site_of_last_call = last(site_id))
# <-- this worked and I'm proud!
sleep_by_user = group_by(sleep, user_id)

 # Extend Here !!!!!
sleepplace[,"V1"] = do(sleep_by_user, data.frame(sleepplace = as.integer(names(sort(table(dodo = .$site_of_last_call),decreasing=TRUE)[1]))))[,"sleepplace"]
## make sure the right user is in the right row because there are 10 entries missing from userid of 
sleepplacenow = do(sleep_by_user, data.frame(sleepplace = as.integer(names(sort(table(dodo = .$site_of_last_call),decreasing=TRUE)[1]))))[,"sleepplace"]

# 
# create new file of ordered indicators (by user id)

INDICATORS_SET2_P01_ordered = tbl_df(INDICATORS_SET2_P01)
INDICATORS_SET2_P01_ordered = arrange(INDICATORS_SET2_P01_ordered, userid)
colnames(INDICATORS_SET2_P01_ordered) = colnames(INDICATORS_SET2_HEADERS)



# find sleeping place most often from sleep dataset and write in sleepplace (done)
# -> site_id for every user_id (done) 
#  - compute sleep for whole SET2_P01 otherwise there are only ca. 35 matches (working on dplyr installation on cluster)

# test the working of dplyr, data.table, tibble, tidyverse and others for version R 3.4.0/3.5.1 (find load command via google)
# prepare small script that loads them and uses a function (one first)
# 
#  - Find a better way for switching between input files (done, whole computation again only takes 15secs)
# add collumn with site_id to ordered indicators
# check out issue with 8449 and 8459 rows / userids in sleepplacenow-
# add collumn with cluster_id for every site_id 
# subset the ordered indicators to include only the first 8800something rows, because only they have values in new rows right now
# compute mean of every indicator (incl. std) for all in same cluster/site_id 
# write it in first_reg_df






save(sleepplace, file = "sleepplace.rda")

