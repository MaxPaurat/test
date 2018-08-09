# this script creates a map of senegal with Voronoi tesselation of antenna sites and colours 
# the areas accourding to input variable

colouredmapfunct = function(z){

#plot with colour
s_poly@data$z = z
p = spplot(s_poly,"z")


#plot hospital locations
# add some data here while traveltimes are not running
lon = SenegalHospitals$lon
lat = SenegalHospitals$lat

lonlat = SpatialPoints(cbind(lon,lat))

hospitallocations = SpatialPointsDataFrame(lonlat, data = as.data.frame(SenegalHospitals$id))

#plot
p = p + layer(panel.points(SenegalHospitals$lon, SenegalHospitals$lat, col="green", pch=19), data=hospitallocations)
print(p)
}