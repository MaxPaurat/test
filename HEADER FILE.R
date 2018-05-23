#Header file
# Call all functions and files in the right order 
# Display the traveltime estimate to closest hospital antenna in map

# LEARN:
# - to use problem description on Git command line

# Today 
# - find estimate of computing time for histograms if only neccessary combinations are calculated, to have a judgement how to proceed
# - Clean files 
#   - (not neccessary now, data input should be fine) try running everything on a different NO machine (also makes me install everything on a second machine)
#   - Done- replace direct paths with a way that is compatible independent of person running it <- DONE FOR Read in Data.R
#   - get data to feuerriegel and ken (use file structure as on ETH machine)
#     -(best to keep structure) share all data with Feuerriegel via polybox?
# - test whether everything is working with clean slate RStudio
# - commit working version to git
# - pull everything from git to laptop
# - delete all similar names/ confusing earlier versions of files and folders on all machines 
# - go through instructions/ideas at the top of files and clean
# - invite feuerriegel and ken to github repository and make pull requests for all files/highlight places where I have questions



library(readxl)
library(rgdal)
library(deldir)
library(ggplot2)
library(rgeos)
library(plyr)
library(rpanel)
library(lattice)
library(latticeExtra)

# Read in Data
source("Read in Data.r")

# Connect Datasets
source("Connect Datasets.r")

# Do calculations on data 
#source("histograms of traveltimes to hospitals.r")

#------Opinion needed here-----------########################################
#source("Towards efficient traveltimes.r")
#------------------------------------########################################

# plot a coloured map -- function input: colour varies by input variable (vector)

source("coloured map.r")

z = 1:1668
colouredmapfunct(z)

