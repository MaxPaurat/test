#exploring mobility data
b = vector(length = 1666)
for (i in 1:1666) {
  if (i %in% rawmobility_subset$site_ID) 
  {b[i] = TRUE}
}
table(b)

#extract small number of users
m = max(rawmobility$user_ID)
keep_user = sample(1:m, 100)

rawmobility_subset = subset(rawmobility, rawmobility$user_ID %in% keep_user)
