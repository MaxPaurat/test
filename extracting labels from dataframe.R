#Tool for viewing labels of variabels in DHS dataframes
data = SNIR6DFL

labe = data.frame(row.names = colnames(data))
for (i in 1:ncol(data)){
 labe[i,1]= attr(data[[i]], "label")
 labe
}
labe[,2] = row.names(labe)
as_data_frame(labe)

colnames(labe) = c("labels", "Variable")


View(labe[grep("education", labe$labels),])
View(labe[grep("place", labe$labels),])
