# script to calculate total number of calls network
# from SET1V

# sequentially load and remove files from workspace
# add total call minutes and number of calls
# matrix with

# SET1V_011 <- read.csv("C:/Users/maxpa/polybox/Masterthesis Mobile Data/Projekte/Masterthesis Mobile Data/test2/test/Data - temporary place to copy to WCP for current computation/SET1V_011.csv", header=FALSE)


#test
# i=2
# infile <- paste("Data - temporary place to copy to WCP for current computation/SET1V_01",i,".csv",sep="")
# 
# data <- read.csv(infile,header=FALSE,sep=",",row.names=NULL)

callnetwork_minutes = matrix(nrow=1666,ncol=1666)
callactivity_number_of_calls_of_towers = numeric(1666) #first in one hour of one day
callactivity_callduration_of_towers = numeric(1666)

# only for the first two days of the year (representativeness?)
for(i in 1:78) {
  infile <- paste("Data - temporary place to copy to WCP for current computation/SET1V_01",i,".csv",sep="")
  print(infile)
  data <- read.csv(infile,header = FALSE)
  data[,1] = as.character(data[,1])
  
    for (j in 1:1666){ #through all towers
    #callactivity_callduration_of_towers[j] = callactivity_callduration_of_towers[j] + sum(data[(data[,"V1"]== "2013-01-01 00") & data[,"V2"] == j,"V5"]) + sum(data[data[,"V3"] == j,"V5"])
    callactivity_number_of_calls_of_towers[j] = callactivity_number_of_calls_of_towers[j] + sum(data[(data[,"V1"]== "2013-01-01 00") & data[,"V2"] == j,"V4"]) + sum(data[data[,"V3"] == j,"V4"])
    }
}

# save(callactivity_callduration_of_towers, file = "callactivity_callduration_of_towers.rda")
# load("callactivity_callduration_of_towers.rda")

save(callactivity_number_of_calls_of_towers, file = "callactivity_number_of_calls_of_towers.rda")
load("callactivity_number_of_calls_of_towers.rda")

#try something even simpler first 
#add call activity for every antenna for one hour of one day
#even this is spread over more than one of the 2mb pieces


