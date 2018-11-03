
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

# take a subset of first 8800 indicators to work with now
# match them with sleepplacenow2 by user_id
# check how indicators user.ids were assigned (right way?) -> yes they existed

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
sleepplacenow2 = do(sleep_by_user, data.frame(sleepplace = as.integer(names(sort(table(dodo = .$site_of_last_call),decreasing=TRUE)[1]))))

# 
# create new file of ordered indicators (by user id)
INDICATORS_SET2_P01 <- read.csv("Data/Challenge Data/SET2/INDICATORS_SET2_P01.CSV", header=FALSE, stringsAsFactors=TRUE)

INDICATORS_SET2_P01_ordered = tbl_df(INDICATORS_SET2_P01)
INDICATORS_SET2_P01_ordered = arrange(INDICATORS_SET2_P01_ordered, userid)[1:8500,] # MARK: change for full analysis
colnames(INDICATORS_SET2_P01_ordered) = colnames(INDICATORS_SET2_HEADERS)
colnames(INDICATORS_SET2_P01_ordered)[1] = "user_id"



  # find sleeping place most often from sleep dataset and write in sleepplace (done)
  # -> site_id for every user_id (done) 
  #  - compute sleep for whole SET2_P01 otherwise there are only ca. 35 matches (done)
  
  # test the working of dplyr, data.table, tibble, tidyverse and others for version R 3.4.0/3.5.1 (find load command via google)
  # prepare small script that loads them and uses a function (one first) (DONE)
  # check local installation of libraries in header file (done some, rest to check when trying to run)
  #
  # long time to copy to cluster in WInSCP always (-> use sync button! (done))
  # (if I click "entfernten ordner auf dem neuesten Stand halten", can't see the results)
  # - terminal coding the copying in cygwin?
  # - option of keeping synchronous
  #   - how fast is the synchronisation
  #   - make sure the synchronised polybox folder doesn't exceed 16 GB (can I install a limit?, choose only some folders for synchronisation?(not reliable, because I could add others to exceed limit))
  #     . will cluster home throw me an error when limit comes? (if yes it's good)
  # 
  #  - Find a better way for switching between input files (done, whole computation again only takes 15secs)

  #priority issues:
  # clean ordner shared from polybox because polybox is full 59GB (problem reduced by deleting Shared folder in polybox, but not fully understood)
  
  # check out issue with 8449 and 8459 rows / userids in sleepplacenow-
  # - put site in the right row in sleepplace
  # - make sleepplace long enough or decide to only haave rows for existing userids (could it be that there are the missing userids somewhere in the other datasets?)
  # - check other structures for this fault 
  
  # add collumn with site_id to ordered indicators
  # add collumn with cluster_id for every site_id 
  # subset the ordered indicators to include only the first 8800something rows, because only they have values in new rows right now
# compute mean of every indicator (incl. std) for all in same cluster/site_id 
# converting factors/characters to num is pain and doesn't give expected result if mutated cullumn is looked at
# write it in first_reg_df


save(sleepplace, file = "sleepplace.rda")

# tests 

# max(INDICATORS_SET2_P01_ordered$user_id)

mergetest = merge(INDICATORS_SET2_P01_ordered, sleepplacenow2)
load("matching_cluster_and_site.Rdata")
trans = transpose(closest_site)
trans$cluster = 1:200
colnames(trans) = c("sleepplace", "cluster") # just for merging 
mergetest2 = merge(mergetest, trans, by="sleepplace")
mergetest2 = arrange(mergetest2,cluster)
mergetest2 = mergetest2[,c(2,36,1,3:35)] # reorder collumns

#group by cluster
INDICATORS_SET2_P01_ordered_and_cluster = tbl_df(mergetest2)

INDICATORS_SET2_P01_ordered_and_cluster = group_by(INDICATORS_SET2_P01_ordered_and_cluster, cluster)
# Indicators_per_cluster = summarize(INDICATORS_SET2_P01_ordered_and_cluster, summarise_all(funs(mean)))

indx <- sapply(INDICATORS_SET2_P01_ordered_and_cluster, is.factor)
INDICATORS_SET2_P01_ordered_and_cluster[indx] <- lapply(INDICATORS_SET2_P01_ordered_and_cluster[indx], function(x) as.numeric(as.character(x)))

Indicators_per_cluster = INDICATORS_SET2_P01_ordered_and_cluster %>% summarise_all(funs(mean(.,na.rm = TRUE))) # 150 cases with sleepplace in clustersites within first 8000 something rows
Indicators_per_cluster = Indicators_per_cluster[,-2] # user_id no sense to be averaged
#
first_reg_df2 = merge(Indicators_per_cluster, first_reg_df)
first_reg_df2 = first_reg_df2[,-(1:2)]

lm.3= lm(rate_of_home_births ~ . , first_reg_df2)
summary.lm(lm.3)

# questions about data

# - why is the responserate variable mostly 0 (check way of calculating it)
# - 

library("foreign")
health_spa = read.dta("Data/DHS Senegal 2012-13/SNFC6IFLSR/SNFC6IFLSR")
a
Data/DHS Senegal 2012-13
