# calculate distances between GPS points of hospitals and antenna locations
# can be made more advanced by taking earth bend into account 

# you get back a data.frame that holds combinations??
# or better to do it in the coloured map file so that Spatial polgons hold the atrtributes (right word?)

# OUTPUT: DATA FRAME WITH ROW IS SITE ID AND COLLUMNS ARE FASTEST REACHABLE HOSPITAL ID, TRAVEL TIME

SenegalHospitals <- read_excel("C:/Users/pauratm/Desktop/Masterthesis Mobile Data/Data/Edwards Data/SenegalHospitals.xlsx")

traveltime2hospitals = function(){
  
  #call file that outputs traveltimes between sites !!!!!!!!!CALCULATE ONLY TO HOSPITAL SITES TO SAVE TIME !!!!!!!!!!
  
  #write in dataframe row (polygon) the closest site ID and travel time
  
  #
  
}





