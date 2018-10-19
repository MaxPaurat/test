# Regression in Rounds

# Coding Notes: 
# . use data.table for faster processing

# Concept Notes:
# . Aggregations can be done on political level to increase usability (arronsisment, communes)
# - inspiration for indicators marked in yellow in "sociodemographic estimation paper"

# Final Optimum
# - Find 5 output variables, criteria:
#   - map is important for something like a vaccination campaign
#   - look into proposal
#   - 
# - Use all available data
# 

# Decision:
# y1 = vaccination rate
# y2 = rate of home births
# y3 = treatment seeking behaviour (e.g. how likely to visit health facility for newborns with fever)
# y4 = treatment seeking behaviour (e.g. how likely to visit health facility for newborns with diarrhea)
# y5 = use of malaria nets
#
# x1 = number of calls, preexisting indicators can be transformed with high impact
# x2 = distance to hospital
# x3 = distance to health facility
# x4 = ...
# x5 = average years of education
# x6 = variance of years of education
# x7 = wealth score
# x8 = disposable income
# x9 = average age
# 
#

# To do:
# -Find health facilities in Senegal, contact tropical institute
# -How do I find how many control variables are neccessary?
#   - wrong question; in this step I only want to show that there is a rough correlation with some control variables
# -Build variables
#   - one by one

# Rounds for amount of Data used:

# Round 0 (no need for cluster computation or traveltime distribution)
# - regression of vacrate on education, ..


# Round 1 (no need for cluster computation)
# - Regression of vacination rate on traveltime to hospital using only the data that I have produced already
#   - implement extraction of typical traveltime from distribution
#
# Round 2 (with cluster computation)
# - Same Regression with more observations
#   - implement cluster particularities
#     - All Output graphics need to be saved
#   - Create folder on cluster to recieve output Data
#   - Change saving destination to be in folder


### Round 0############ data preparation for first regression of "place of delivery of frist child" on "total years of education of mother " 
#m15_1 place of delivery first child - answer 10,11,12 is home
#todo
# - take out 
#     NAs
#     don't know answers 90-99
#     
# - 

#clean all cases that have NA in m15_1
SN_m15_1_v133_clean = SNIR6DFL[!is.na(SNIR6DFL$m15_1)&!(SNIR6DFL$m15_1) %in% c(seq(90:99))&!is.na(SNIR6DFL$v133)&!(SNIR6DFL$v133 %in% c(seq(90:99))),]

#combine clusters to rates
# create help variable to get rate of home births per cluster
x = SN_m15_1_v133_clean$m15_1
#home is 1 ; everything else 0 (find a better way!!!)
x = replace(x, x %in% c(10,11,13), 1) 
x = replace(x, x != 1, 0) 

#attach help variable to dataframe
SN_m15_1_v133_clean$m15_1rate_help_col_recoded = x
#compute average rate by cluster
first_reg_df = aggregate(SN_m15_1_v133_clean$m15_1rate_help_col_recoded, list(SN_m15_1_v133_clean$v001), mean)
# agregate the education variable 
educ_by_cluster = aggregate(SN_m15_1_v133_clean$v133, list(SN_m15_1_v133_clean$v001), mean)
#change name of column
colnames(educ_by_cluster) = c("a", "average years of education")
#attach the education variable
first_reg_df$educ_by_cluster = educ_by_cluster$`average years of education`
#give good variable names
colnames(first_reg_df) = c("cluster", "rate_of_home_births", "average_years_of_education")

#create a fucking linear model 
lm.1 = lm(rate_of_home_births ~ average_years_of_education , first_reg_df)

lm.1

# Round 0.1#
# extend to calls
# source("creating callnetwork.R")

# 
# load (matching_cluster_and_site.Rdata)
load("C:/Users/maxpa/polybox/Masterthesis Mobile Data/Projekte/Masterthesis Mobile Data/test2/test/matching_cluster_and_site.Rdata")

# callactivity_callduration_of_towers (row is site) , closest_site (column is cluster, value is site) 

callvar = numeric(200)
for (i in 1:200){
  callvar[i] = callactivity_callduration_of_towers[closest_site[1,i]]
}

first_reg_df$callactivity_callduration_of_closest_tower = callvar

callvar2 = 

lm.2 = lm(rate_of_home_births ~ average_years_of_education + callactivity_callduration_of_closest_tower, first_reg_df)

lm.2

# remember displacement 2km for urban and 5km for rural
# to estimate the effect, create statistics of sizes of width and height of voronoi polygons

# Going full berserk
# attacking the indicators

# . They are connected to the mobility data (I have to decide for a 
#   way they are mapped to the sites: sleeping place?(location of most call betweeen 9 and 5? (annoying to code)))
#      - in sociodemographic paper they are wheighting (sleeping place makes more sense because it's where they would show up in a survey)
# how: last call of the day
# - iterate through dates, pick min time distance to 00:00
# - match mobility and indicators (makes sure the same numbers appear is both user_id collumns)
# 



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
# First_Site_ID = 856
# 
keep_site = calc_hospitals_sites(hospital_number)
# sub = calc_hospitals_rawmobility_subset(hospital_number, keep_site = keep_site)
# travel_time = trtime_hist(hospital_number, sub = sub)


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

