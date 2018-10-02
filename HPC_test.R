print("Hello HPC world")

#install.packages("haven")
library(foreign)
SNIR6DFL <- read.dta("SNIR6DFL.DTA")
#save(SNIR6DFL, SNIR6DFL_Rsave)
write.table(SNIR6DFL, file = "SNIR6DFL.txt", sep = " ")
