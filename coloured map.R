# this script creates a map of senegal with Voronoi tesselation of antenna sites and colours 
# the areas accourding to input variable

colouredmapfunct = function(z){

#plot with colour
p = spplot(s_poly, zcol="z")
print(p)

# add some data here while traveltimes are not running
lon = SenegalHospitals$lon
lat = SenegalHospitals$lat

lonlat = SpatialPoints(cbind(lon,lat))

hospitallocations = SpatialPointsDataFrame(lonlat, data = as.data.frame(SenegalHospitals$id))

#plot hospital locations
p + layer(panel.points(SenegalHospitals$lon, SenegalHospitals$lat, col="green", pch=19), data=hospitallocations)

}