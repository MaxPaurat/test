

for (i in 1:1668){ # for all s_poly polygons
bool = FALSE 
plgn = as.matrix(s_poly@polygons[[i]]@Polygons[[1]]@coords)
  
bool = point.in.polygon(hospitallocations$lon[22], hospitallocations$lat[22], plgn[,1], plgn[,2])
  
  if (bool==1){
    print("The site_ID of Louga hospital 22 is ")
    print(i)
    break
  }
}