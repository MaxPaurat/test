# Efficiency improvements to histograms of traveltimes to hospitals

#Assign Hospitals to antennas
#use over() funtion to say in which polygon a point is located

lon = SenegalHospitals$lon
lat = SenegalHospitals$lat

lonlat = SpatialPoints(cbind(lon,lat))

hospitallocations = SpatialPointsDataFrame(lonlat, data = as.data.frame(SenegalHospitals$id))

assign_hospital2site = over(lonlat, s_poly)


# create the histograms of travel times to hospital sites

# !!!!!TAKES TOO LONG!!!!

# 
# - needs to be rewritten to process data more efficiently
# 
# ideas: 
# - done on Euler
# - print computing times of nested loops to estimate runtime on this machine
#   - Problem: makes only limited sense because final algorithm should go through all data once only..
#     .. currrently all data is scanned for a combination of two sites 
#       - how would a more efficient algorithm look?
# - make searches of travels only in surrounding area
#   - make additional layer of new voronoi areas with hospital points 
#     - problem that interesting site connections are not found
#   - draw circle around all hospitals with radius equal to distance to third-fifth closest other hospital 
#     - include check whether all sites are included
#   - ! calculate the closest hospitals from all sites via geographical distance and consider only three closest
# - seperate analysis into Dakar, Rest and South (like in Orange paper)
# - use lapply functions
# - ! ask feuerriegel for input

# First_Site_ID = 461 # first set the Sites manually, later create a loop
# Sec_Site_ID = 454

travel_time <- array(dim = c(1666,1666,300))

for (First_Site_ID in c(1:10)){ # these should be all sites 
  for (Sec_Site_ID in c(assign_hospital2site$z)){ # these should be the sites that have health facilities
    
    nummer = 0 # initialize count of travels with this Site combination (see use below)
    
    for (i in 1:max(rawmobility$user_ID)){ # for every user seperate data.frame to work on
      #print(i)
      user = subset(rawmobility, user_ID == i) 
      if (nrow(user) == 0){break}
      #print(user)
      S = NA # set travel start time to NA
      
      for (counter in 1:nrow(user)){ # for all observations of the user (call/sms at a site)
        #print(counter)
        if (user[counter, ]$site_ID == First_Site_ID){ # if user visits first site 
          S = user[counter, ]$timestamp # save travel starttime and date (this gets replaced by the last time the person is at the site)
          #print("I found one!!!")
          
        }
        if (user[counter, ]$site_ID == Sec_Site_ID & is.na(S) == FALSE){ # if user visits second site and has visited first already
          nummer = nummer + 1
          E = user[counter, ]$timestamp # record travel arrival time and date
          travel_time[First_Site_ID, Sec_Site_ID, nummer] = as.numeric(as.POSIXct(E, format = "%Y-%m-%d %H:%M:%S") - as.POSIXct(S, format = "%Y-%m-%d %H:%M:%S")) #as.Date(E) - as_Date(S)) #calculate travel time as difference of S and E
          print("I found one!!!")
          #stop()
        }
      }
    }
    print("done looping")
    if (nummer != 0 ){ 
      #plot histograms
      #hist(travel_time[First_Site_ID, Sec_Site_ID, ], breaks = 0:(max(travel_time[First_Site_ID, Sec_Site_ID, ]+2, na.rm = TRUE)))
    }
  }
}

