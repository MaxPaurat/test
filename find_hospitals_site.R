# closest site from hospital or
# finding the site_number of hospitals

find_hospitals_site = function(hospital_number){
  
  hospital_number = 22
  # Create Matrix with distances between antennas and hospitals, 
  # also create matrix with closest hospitals for every antenna
  
  
  # Matrix rows site ID
  # collumns hospitals id
  df_sites = data.frame(sitelocations[,"lon"], sitelocations[,"lat"])
  df_hosp = data.frame(SenegalHospitals$lon, SenegalHospitals$lat)
  
  distance.matrix = distm(df_sites, df_hosp, fun=distGeo)
  
  colnames(distance.matrix) <- as.character(SenegalHospitals$new_id)
  
  # for every collumn (hospital)
  
 # hospital_sites = apply(min(distance.matrix[])
                         
                         
  n <- 1
  closest_site <- matrix(0,1,ncol(distance.matrix))
  for (v in 1:ncol(distance.matrix)){
    ordered <- order(distance.matrix[,v])
    closest_site[1,v]<- ordered[1]
  }  
  closest_site = as.data.frame(closest_site)
  
  save(closest_site, file= "closest_site.Rdata")
  
  
  hospsite_number = closest_site[1,hospital_number]
  
  return(hospsite_number)
}