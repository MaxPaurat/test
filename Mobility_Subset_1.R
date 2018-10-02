# subset antennas that have Louga hospital (22) as closest hospital

site_ID = 1:1668
closest_hospitals = cbind(closest_hospitals,site_ID)

keep_site = closest_hospitals[closest_hospitals[,1] == 1,]
keep_site

subset_1 = subset(rawmobility, rawmobility$site_ID %in% as.numeric(keep_site$site_ID))
print("generated subset_1")


