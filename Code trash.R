# Code trash

##############histograms of travel times to hospitals######################

#### first try
# First_Site_ID = 1
# 
# Sec_Site_ID = 900
# 
# wenttoFirstSite = rawmobility[rawmobility$site_ID == First_Site_ID, ]
# UserFirst = wenttoFirstSite$user_ID
# 
# #add something here to amke sure the second time is after first
# wenttobothSites = rawmobility[ rawmobility$user_ID == User & rawmobility$site_ID == Sec_Site_ID, ]
# 
# UserFirstandSec = wenttobothSites$user_ID
# 
# 
# 
# Endtime = wenttobothSites$timestamp
#################
#STEPS TO SOLVE THE PROBLEM
#users visits to one site first and then the other

#for user_ID
# visits where First site is visited then second without the first again in between

# find incidence of visit to first
# look to next observation
# if visit to the same site, save the new time as starttime
# if not the same go through further observations of this user to find visit to second site
# lock arrival this time 
# calculate this difference and save to vector of this site combination (has direction)
# continue with this process on this user until no data for this user is left
#################
#second try
# First_Site_ID = 1
# Sec_Site_ID = 900
# 
# rawmobility$user_ID
# 
# for (i in 1:max(rawmobility$user_ID)){
#   if (( rawmobility$user_ID == i) & (First_Site_ID %in% rawmobility$site_ID))
# Time1 = 
# }

#third try (loops are inefficient and should be replaced, append is also inefficient)
# 