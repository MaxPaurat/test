


#Goal: Make a fast test of hospital closeness variable in regression, use a smaller dataset to save computation 

# should be as representative as easily possible
# there should be a few travels for each (relevant) distance
# relevant is the area around a hospital where people choose this hospital
# Options:
#  - voronoi tesselation of hospital cachment areas
#     - difficulty is here to judge how long people would go extra for a better hospital
#       but the aim here is to make the travel time to hospital a feature of a site area
#       -> use the closest hospital in time 
#         - time is not available now 
#           -> add a distance to make overlapping tesselations 
#             - not simple to implement
#             - using road network is also not simple
#       -> use closest in space
#         - for some the areas the traveltime seems longer then it is, because at the traveltime to 2./3. closest is not calulated
#           - analyse this bias afterwards
#             - by sorting the closest hospitals for each antenna and adding the second to the list to calc. with mobile data
#       -> use human decision algorithm like:
#           - if distances are long I would not go to hospitals more the 1,5 the distance to closest 
#           - if distances are short I would accept a longer way to get a better hospital
#       - sorting closest and considering two 

# Decision: 
# Sort for each site the hospitals in closeness, use the closest now (using other hospitals also in more advanced analysis for later)
# Use this hospital in Louga as Test (has some diversity of rural-urban)

# dataset should have following characteristics:
# - defined region 
# - in this region all antennas should appear
#   - could a stratified sample be an idea? where all antennas appear proportional to their appearance in all data
#   -> not super important, regression can work with missing elements
# - little bias (e.g. because of unknown structure in UserIDs) 
#   - now structure known in userIDs, to be safe we could jiggle them so they are in random position
# 

# Definately split Senegal into two areas because of Gambia (not really priority for now)
# - how to identify the siteIDs?
#   - check in orange paper how
#   - 


# Create Small Dataset of antennas that have Louga as closest antenna





# #### Exploration ########
# 
# #extract small number of users
# m = max(rawmobility$user_ID)
# keep_user = sample(1:m, 100)
# 
# rawmobility_subset = subset(rawmobility, rawmobility$user_ID %in% keep_user)
# 
# #exploring mobility data
# 
# #Answering how many sites appear in the subset
# b = vector(length = 1666)
# for (i in 1:1666) {
#   if (i %in% rawmobility_subset$site_ID)
#   {b[i] = TRUE}
# }
# table(b)
# 
# #Answering how many sites appear in the 1ST DATASET
# b = vector(length = 1666)
# for (i in 1:1666) {
#   if (i %in% rawmobility$site_ID)
#   {b[i] = TRUE}
# }
# table(b)