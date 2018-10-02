# tests
# X = travel_time[First_Site_ID, 1, ]
# hist(X, prob=FALSE, col="grey")# prob=TRUE for probabilities not counts
# 
# dataset = as.data.frame(travel_time[First_Site_ID, 1, ])
# ggplot(dataset, aes(x = X)) + 
#   geom_histogram(aes(y = ..density..)) + 
#   geom_density()


f1 = function(x){
  
  gold = x*x
  return(gold)
}

