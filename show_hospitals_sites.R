# Show maps of sites assigned to hospitals by Closest Hospitals Matrix.R


show_hospitals_sites = function (hospsite_number){
  
  keep_site = calc_hospitals_sites(hospsite_number)
  
  z = vector(length = 1668)
  for (i in 1:1668) {
    if (i %in% as.numeric(keep_site$site_ID))
    {z[i] = TRUE}
  }
  z= as.numeric(z)
  
  p = colouredmapfunct(z)
  print(p)
  graphics.off()
  ggsave(filename=paste("sites around hospital ", hospsite_number), plot = p)
} 

for (i in 1:40){
  show_hospitals_sites(i)
}