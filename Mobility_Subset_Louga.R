# subset antennas that have Louga hospital (22) as closest hospital

site_ID = 1:1668
closest_hospitals = cbind(closest_hospitals,site_ID)

keep_site = closest_hospitals[closest_hospitals[,1] == 22,]
keep_site

Louga_subset = subset(rawmobility, rawmobility$site_ID %in% as.numeric(keep_site$site_ID))
print("generated the Louga subset")





############ Temporary code trash #######################

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



# z = vector(length = 1668)
# for (i in 1:1668) {
#   if (i %in% as.numeric(815:815))
#   {z[i] = TRUE}
# }

# z = vector(length = 1668)
# for (i in 1:1668) {
#   if (i %in% as.numeric(keep_site))
#   {z[i] = TRUE}
# }

# s_poly@data$z = z
# p = spplot(s_poly, "z")
# print(p)

# antenne 819 liegt gerade in polgon 815
#plot
#p + layer(panel.points(antennalocations$lon[819:819], antennalocations$lat[819:819], col="green", pch=19), data=antennalocations)
