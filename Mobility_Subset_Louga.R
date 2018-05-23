
# subset antennas that have Louga hospital as closest hospital
#
#I have closest_hospital

# Find Hospital id of Louga: 27

# #only for now
# ids = 1:1666
# closest_hospital = cbind(ids, sample(1:40, 1666, replace = TRUE))
# 
# #colnames(closest_hospital) = c("V1","V2")
# 
# 
# keep_site = closest_hospital[closest_hospital$V2 == 27,]
# keep_site
# 
# Louga_subset = subset(rawmobility, rawmobility$site_ID %in% keep_site$ids)


#now with real data
closest_hospitals$site_ID = 1:1666

keep_site = closest_hospitals[closest_hospitals[,1] == 22,]
keep_site

Louga_subset = subset(rawmobility, rawmobility$site_ID %in% as.numeric(keep_site$site_ID))


