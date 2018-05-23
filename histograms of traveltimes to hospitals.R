#create histograms of travel times to hospitals
#this is the basis for creating an algorthm to extract the typical fast travel time distribution (without stops 
#somewhere)
#ideas: fit gaussian distr. 
# - maybe the modes of transport ( car, plane, ...) should be clustered before?
# - how can I validate the distribution?
#   - definately compare to simple distance-carspeed calculation
#   - validate with results from other orange paper on travel times between cities
#   - crosscheck by adding two (or more) distances that combine to make the journey

#ISSUES:
# - number of travels between some antennas are very low resulting in unreliable traveltime estimates ("peak is less clear")
#   - POSSIBLY CAN BE RESOLVED BECAUSE TRAVEL TIMES TO HOSPITALS ARE TYPICALLY LESS THEN 500MIN (200KM IN ORANGE PAPER) WHERE 
#     ESTIMATES ARE VARYING LESS DRAMATICALLY 
#To Do 
# - implement typical travel time extraction strategy as in orange paper
# - run with more data to see how smooth the distributions are
# - ESTIMATE HOW LONG THE CODE WOULD RUN WITH FOR LOOPS AND ALL DATA -> DECIDE WHETHER I NEED TO FIND ANOTHER WAY (EULER
#   ODER MORE EFFICIENT FUNCTIONS)

#!!!!!!!!!CALCULATE ONLY TO HOSPITAL SITES TO SAVE TIME !!!!!!!!!!!!!!!!


# First_Site_ID = 461 # first set the Sites manually, later create a loop
# Sec_Site_ID = 454

#Assign Hospitals to antennas
#use over() funtion to say in which polygon a point is located

lon = SenegalHospitals$lon
lat = SenegalHospitals$lat

lonlat = SpatialPoints(cbind(lon,lat))

hospitallocations = SpatialPointsDataFrame(lonlat, data = as.data.frame(SenegalHospitals$id))

assign_hospital2site = over(lonlat, s_poly)

SenegalHospitals = cbind(SenegalHospitals, assign_hospital2site)

colnames(SenegalHospitals)[colnames(SenegalHospitals)=="z"] <- "site_ID"

#spplot(hospitallocations)



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

# Calculate which hospital is closest to antennas

source("Closest Hospitals Matrix.r")



# Calculate traveltime for antennas closest to Louga Hospital




subset = Louga_subset
included_sites = keep_site$ids
included_hospitals_sites = 855 # Louga site_ID
travel_limit = 10
travel_time_Louga <- array(dim = c(1666,1,travel_limit))
travel_time = travel_time_Louga

for (First_Site_ID in included_sites){ # these should be all sites 
  for (Sec_Site_ID in included_hospitals_sites){ # these should be the sites that have health facilities
    
    nummer = 0 # initialize count of travels with this Site combination (see use below)
    
    for (i in subset$user_ID){ # for every user seperate data.frame to work on
      #print(i)
      user = subset(subset, user_ID == i) 
      if (nrow(user) == 0){break}
      #print(user)
      S = NA # set travel start time to NA
      
      for (counter in 1:nrow(user)){ # for all observations of the user (call/sms at a site)
       #print(counter)
        print(nummer)
        if (nummer = travel_limit){print("enough travels for this site combination") break} #stop searching for more travels if limit is reached
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
      hist(travel_time[First_Site_ID, Sec_Site_ID, ], breaks = 0:(max(travel_time[First_Site_ID, Sec_Site_ID, ]+2, na.rm = TRUE)))
    }
  }
}

