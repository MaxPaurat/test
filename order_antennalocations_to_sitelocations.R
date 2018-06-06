# ordnet die Antennalocations daten in der gleichen Reihenfolge wie im SpatialpolygonsDataframe s_poly und nennt
# die neue Ordnung sitelocations

sitelocations = matrix(NA,1668, 4)

for (i in 1:1668){ # for all s_poly polygons
  
  plgn = as.matrix(s_poly@polygons[[i]]@Polygons[[1]]@coords)
  
  for (j in 1:1668){ # check through all antennalocations
  bool = FALSE
  #print ("GO")
  
  bool = point.in.polygon(antennalocations$lon[j], antennalocations$lat[j], plgn[,1], plgn[,2])
    print(bool)
    if (bool==1){
      sitelocations[i,1] = antennalocations$lon[j]
      sitelocations[i,2] = antennalocations$lat[j]
      print(i)
      break
    }
  }
}
colnames(sitelocations) = (c("lon", "lat", "not used", "notused"))

save(sitelocations, file= "sitelocations_file.Rdata")
