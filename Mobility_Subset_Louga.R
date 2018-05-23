# solve part probelem
#
# subset antennas that have Louga hospital as closest hospital
#
#I have closest_hospital

# Find Hospital id of Louga: 27

#only for now
ids = 1:1666
closest_hospital = cbind(ids, sample(1:40, 1666, replace = TRUE))

#colnames(closest_hospital) = c("V1","V2")
rownames(closest_hospital) = 1:1666

keep_site = closest_hospital[closest_hospital$V2 == 27,]
keep_site

Louga_subset = subset(rawmobility, rawmobility$site_ID %in% keep_site$ids)
