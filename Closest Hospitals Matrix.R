# Create Matrix with distances between antennas and hospitals, 
# also create matrix with closest hospitals for every antenna


# Matrix rows site ID
# collumns hospitals id
df_sites = data.frame(sitelocations[,"lon"], sitelocations[,"lat"])
df_hosp = data.frame(SenegalHospitals$lon, SenegalHospitals$lat)

distance.matrix = distm(df_sites, df_hosp, fun=distVincentyEllipsoid)

colnames(distance.matrix) <- as.character(SenegalHospitals$new_id)

# for every station sort and select the nearest station
n <- 5
closest_hospitals <- matrix(0,nrow(distance.matrix), n)
for (v in (1:nrow(distance.matrix))){
  ordered <- order(distance.matrix[v,])
  closest_hospitals[v,]<- ordered[1:5]
}  
closest_hospitals = as.data.frame(closest_hospitals)

site_ID = 1:1668
closest_hospitals = cbind(closest_hospitals,site_ID)
