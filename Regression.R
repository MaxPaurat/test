# Regression 

# To do

# - Read in the data
# - find reg function
# - 
# not neccessary that I have all sites in the dataset for first try
# 
# Weiteres Vorgehen:
# 
# . (DONE) invite Ken to github repo
# . implement closest hospital, single out Louga and one in Dakar in exploring mobility file
# . implement regression on smaller data
# . prepare data file on harddrive to bring to meeting with feuerriegel
#   -the next few analysis and computation should be likely to work on this dataset aswell 
# . create Readme to give instructions to feuerriegel
# . invite Feuerriegel to github
# . write/meet feuerriegel

# Later:
# . Make files into functions?


source("HEADER FILE.R")

# Calculate which hospital is closest to which antennas, IS SAVED
#source("Closest Hospitals Matrix.r")

# #Generate mobility dataset around Louga (subset of rawmobility)
# source("Mobility_Subset_louga.R")§§

# Filling "travel_time" array for Louga area
source("histograms of traveltimes to hospitals.R")

hospital_number = 22
First_Site_ID = 856

keep_site = calc_hospitals_sites(hospital_number)
sub = calc_hospitals_rawmobility_subset(hospital_number, keep_site = keep_site)
travel_time = trtime_hist(hospital_number, sub = sub)


load(file=paste("Data_histogram_hospital_", hospital_number, "_Site_", 856, ".RData",sep=""))


#Display Louga subset as map

z = vector(length = 1668)
for (i in 1:1668) {
  if (i %in% as.numeric(keep_site$site_ID))
  {z[i] = TRUE}
}
z= as.numeric(z)

colouredmapfunct(z)
# # 
# source("extract typical traveltimes from histograms.R")
# 
# source("run Regression.R")

