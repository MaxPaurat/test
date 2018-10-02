# extract_dta_labl = function (dtaobject) {
# 
#   for (i in ncol(dtaobject)) {
#     x = colnames(dtaobject)[i]
#       
#       y[i] = attr(SNKR6DFL, "label")
#       return = y
#     
#   }
# }
# 
# apply(SNKR6DFL, function())

extract_dta_labl = function (dtaobject) {
  
  for (i in ncol(dtaobject)) {
    
    
    y[i] = attr(SNKR6DFL[,i], "label")
    return = y
    
  }
}