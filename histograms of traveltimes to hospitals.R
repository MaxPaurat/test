#create histograms of travel times to hospitals

# There are few travels in the first 25th of all data, close to Louga hospital
# Options:
# - Use all data
# -----> !!!!!!!! Use different hospital !!!!!!!!!!!!!!!!!!!!!! <--------

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


# Calculate traveltimes to Louga Hospital for antennas closest to this hospital
# in general form change the 1 to Sec_Site_ID here -> travel_time[First_Site_ID, 1, nummer] = as.numeric(as.POSIXct(E, format = "%Y-%...

# can be extended to count a journey in the opposing direction 

calc_hospitals_sites = function (hospital_number){
  
  load("closest_hospitals.RData")

  #if (keep_site$hosp_number[1] != hospital_number){
  keep_site = closest_hospitals[closest_hospitals[,1] == hospital_number,]
  keep_site$hosp_number = hospital_number
  
  sub = subset(rawmobility, rawmobility$site_ID %in% as.numeric(keep_site$site_ID))
  print(paste("generated subset of hospital ", hospital_number))
  #}

return(keep_site)
}

source("find_hospitals_site.R")

calc_hospitals_rawmobility_subset = function (hospital_number, keep_site){
  
sub = subset(rawmobility, rawmobility$site_ID %in% as.numeric(keep_site$site_ID))
print(paste("generated subset of hospital ", hospital_number))
return(sub)

}

trtime_hist = function(hospital_number, sub){

print("Calculating histograms for these sites:")
#print(keep_site)
  
# Find hospsite_number from hospital number
hospsite_number = find_hospitals_site(hospital_number = hospital_number)

included_hospitals_sites = hospsite_number  #866 #855 # Louga site_ID
included_sites = keep_site$site_ID[!keep_site$site_ID %in% included_hospitals_sites] #855 #keep_site$site_ID[17:41]
travel_limit = 300 #limit number of entries of travel instances

travel_time <- array(dim = c(1666,1,travel_limit))
travel_instance_new = 0
unique_user_IDs = unique(sub$user_ID)

for (First_Site_ID in included_sites){ # these should be all sites 
  for (Sec_Site_ID in included_hospitals_sites){ # these should be the sites that have health facilities
    
    nummer = 1 # initialize count of travels with this Site combination (see use below)
    
    for (i in unique_user_IDs){ #Look at one user
      
      if (nummer == travel_limit + 1){
        print("enough travels for this site combination") 
        break
      } #stop searching for more travels if limit is reached
      
      # print("user_ID is ")
      # print(i)
      user = subset(sub, user_ID == i) # for every user seperate data.frame to work on
      if (nrow(user) == 0){break}
      #print(user)
      S = NA # set travel start time to NA
      
      for (counter in 1:nrow(user)){ # for all observations of the user (call/sms at a site)
       
        
        # print(counter)
        # print("nrow(user):")
        # print(nrow(user))
        if (nummer == travel_limit+1){
          break
        } #stop searching for more travels if limit is reached
        
        if (user[counter, ]$site_ID == First_Site_ID){ # if user visits first site 
          S = user[counter, ]$timestamp # save travel starttime and date (this gets replaced by the last time the person is at the site)
          S_row = user[counter, ]
          travel_instance_new = 1 # record that S has changed (to prevent more then one instance for one starttime)
          #print("I found one!!!")
        }
        
        if ((user[counter, ]$site_ID == Sec_Site_ID) & (is.na(S) == FALSE) & (travel_instance_new == 1)){ # if user visits second site and has visited first already
          travel_instance_new = 0 # record that first matching second site was found 
          E = user[counter, ]$timestamp # record travel arrival time and date
          E_row = user[counter, ]
          travel_time[First_Site_ID, 1, nummer] = difftime(as.POSIXct(E, format = "%Y-%m-%d %H:%M:%S"), as.POSIXct(S, format = "%Y-%m-%d %H:%M:%S"), unit = "min") #as.Date(E) - as_Date(S)) #calculate travel time as difference of S and E
          print("Found the travel nummer:")
          print(nummer)
          print("and time (in min)")
          print(travel_time[First_Site_ID, 1, nummer])
          # print("counter:")
          # print(counter)
          print("Rows of Start and Endtimes")
          print(S_row)
          print(E_row)
          
          nummer = nummer + 1
          #print("I found one!!!")
          #stop()
        }
      }
    }
    
    #plot histograms (general form)
    #hist(travel_time[First_Site_ID, Sec_Site_ID, ], breaks = 0:(max(travel_time[First_Site_ID, Sec_Site_ID, ]+2, na.rm = TRUE)))
    
    dataset = as.data.frame(travel_time[First_Site_ID, 1, ])
    colnames(dataset) = "time"
    sitecount = which(included_sites == First_Site_ID)
    #plot histograms (Louga specific)
    if (is.na(travel_time[First_Site_ID, 1, 1])){ 
    print("vector empty, no traveltimes found")
    }else{
    # hist(travel_time[First_Site_ID, 1, ], breaks = 0:(max(travel_time[First_Site_ID, 1, ]+2, na.rm = TRUE)))
     
     #hist(travel_time[First_Site_ID, 1, ], col="grey",  main = paste("Histogram of Site" , First_Site_ID))# prob=TRUE for probabilities not counts
      
      # histogram = qplot(dataset,
      #       geom="histogram",
      #       binwidth = 30,  
      #       main = "Histogram for traveltimes", 
      #       xlab = "Traveltime (min)",  
      #       fill=I("blue"))
      # print(histogram)
      # ggplot(data=dataset, aes(x= travel_time[First_Site_ID, 1,])) + geom_histogram()
      
      histo = ggplot(dataset, aes(dataset$time)) +
        geom_histogram(binwidth = 30) +
        geom_density(bw = 30) +
        ggtitle(paste("Histogram for Site ", First_Site_ID, " the ", sitecount, "antenna in this subset")) +
        labs(x="traveltime (min)") +
        coord_cartesian(xlim = (c(0,2880))) 
      
      
      
      assign(x=paste("histogram_hospital_", hospital_number,"_Site_", First_Site_ID, sep=""), histo)
      assign(x=paste("Data_histogram_hospital_", hospital_number,"_Site_", First_Site_ID, sep=""), dataset)
      
      save(list = paste("Data_histogram_hospital_", hospital_number,"_Site_", First_Site_ID, sep=""), file = paste("Data_histogram_hospital_", hospital_number,"_Site_", First_Site_ID,".RData", sep=""))
      ggsave(filename = paste("histogram_hospital_", hospital_number,"_Site_", First_Site_ID, ".pdf", sep=""), plot = histo, device="pdf") 
                       
      print(histo)
      
      
      # dataset = as.data.frame(travel_time[First_Site_ID, 1, ])
      # histogram = ggplot(dataset, aes(x = X)) + 
      #   geom_histogram(aes(y = ..density..), binwidth = 10) + 
      #   geom_density() 
      #   coord_cartesian(xlim = c(0, 00)) 
      # histogram
    }
  }
}

print("done")
return(travel_time)
} # function definition end

# Solving the problems
# Options:
# - Go through printed output and identify problems/structures
#   - Why does the first instance get printed twice before all others in cycles?
#     . 
# - Run on ETH machine to make things faster
# - make loops stop after they identified all unique travel instances
# - understand double display
# - prevent double/multiple counting if second/further instances of second site occur before new first site if found
# 
# puzzeling things:
# - in general there are few instances found
#   - do I have to worry about very low number of instances for some sites?
#   - NO - can this be tested without running the code on all data for these combinations?
#     - Get overview of how many instances occur for the Louga subset of the data
