# Create Matrix with distances between antennas and hospitals, 
# also create matrix with closest hospitals for every antenna


# Matrix rows site ID
# collumns hospitals id
df_sites = data.frame(antennalocations$lon, antennalocations$lat)
df_hosp = data.frame(SenegalHospitals$lon, SenegalHospitals$lat)

distance.matrix = distm(df_sites, df_hosp, fun=distVincentyEllipsoid)

colnames(distance.matrix) <- as.vector(SenegalHospitals$id)

# for every station sort and select the nearest station
n <- 5
closest_hospitals <- matrix(0,nrow(distance.matrix), n)
for (v in (1:nrow(distance.matrix))){
  ordered <- order(distance.matrix[v,])[1:n]
  closest_hospitals[v,]<- colnames(distance.matrix)[ordered]
}  
closest_hospitals 