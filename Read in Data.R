#Read in Data

##### DHS #####
#DHS Cluster Coordinates#
DHSshapefile = readOGR("Data\\DHS Senegal 2012-13\\Stata\\SNGE6AFL","SNGE6AFL")
plot(DHSshapefile)

##### Mobile Data #####

# Mobility data
rawmobility = read.csv( "Data\\Challenge Data\\SET2\\SET2_P01small.CSV", header = FALSE)
colnames(rawmobility) = c("V1"="user_ID", "V2"="timestamp", "V3"="site_ID")
rawmobility$timestamp = as.character(rawmobility$timestamp)

# Antenna site locations
antennalocations = read.csv("Data\\Challenge Data\\ContextData\\SITE_ARR_LONLAT.CSV", header = TRUE)

##### Additional Data #####

# Hospital locations
SenegalHospitals <- read_excel("Data/Edwards Data/SenegalHospitals.xlsx")
SenegalHospitals$new_id = 1:40

# Country borders 
SEN <- readOGR(dsn = "Data/Edwards Data/Input Data Edward", layer = "SEN_outline")
SEN_level_1 <- readOGR(dsn = "Data/Edwards Data/Input Data Edward", layer = "SEN-level_1")
SEN_arr <- readOGR(dsn = "Data/Edwards Data/Input Data Edward", layer = "senegal_arr_2014_wgs")