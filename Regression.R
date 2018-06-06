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

# Calculate which hospital is closest to which antennas
source("Closest Hospitals Matrix.r")

#Generate mobility dataset around Louga (subset of rawmobility)
source("Mobility_Subset_louga.R")

# Filling travel_time for Louga area
source("histograms of traveltime to hospitals.R")

# 
source("extract typical traveltimes from histograms.R")

source("run Regression.R")

