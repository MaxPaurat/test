#print cluster locations

# closest site from hospital or
# finding the site_number of hospitals

find_clusters_site = function(cluster_number){
  
  # Create Matrix with distances between antennas and hospitals, 
  # also create matrix with closest hospitals for every antenna
  
  
  # Matrix rows site ID
  # collumns cluster DHSID
  df_sites = data.frame(sitelocations[,"lon"], sitelocations[,"lat"])
  df_clusters = data.frame(DHSshapefile@data$LONGNUM, DHSshapefile@data$LATNUM)
  
  distance.matrix = distm(df_sites, df_clusters, fun=distGeo)
  
  colnames(distance.matrix) <- as.character(DHSshapefile@data$DHSID)
  
  # for every collumn (hospital)
  
  # hospital_sites = apply(min(distance.matrix[])
  
  
  n <- 1
  closest_site <- matrix(0,1,ncol(distance.matrix))
  for (v in 1:ncol(distance.matrix)){
    ordered <- order(distance.matrix[,v])
    closest_site[1,v]<- ordered[1]
  }  
  closest_site = as.data.frame(closest_site)
  
  save(closest_site, file= "matching_cluster_and_site.Rdata")
  
  
  clustersite_number = closest_site[1,cluster_number]
  
  return(clustersite_number)
}

clustersites = matrix(0,1,200)
for (i in 1:200){
  clustersites[1,i] =  find_clusters_site(i)
  
}







