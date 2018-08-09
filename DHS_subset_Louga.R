#DHS Subset Louga


cluster_ID = 1:200
clustersites = rbind(clustersites,cluster_ID)

keep_clusters = clustersites[clustersites[1,] %in% keep_site,]
keep_clusters

Louga_subset = subset(SNKR6DFL, SNKR6DFL$cluster_ID %in% as.numeric(keep_clusters$cluster_ID))
print("generated the Louga subset")
