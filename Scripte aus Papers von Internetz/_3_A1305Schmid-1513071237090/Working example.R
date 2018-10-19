#===================================================================================================
# SUBJECT:  Example code for Fay-Herriot Function with arcsin transformation
# AUTHOR:   Timo Schmid, Fabian Bruckschen, Nicola Salvati and Till Zbiranski, June 06, 2017
# TITLE:    Example code for the paper "Constructing socio-demographic indicators for National
#           Statistical Institutes using mobile phone data: estimating literacy rates in Senegal"
#===================================================================================================

# Load Packages ------------------------------------------------------------------------------------
require(MASS)
require(nlme)
require(formula.tools)

# Load Data ----------------------------------------------------------------------------------------
setwd("C:/Users/maxpa/polybox/Masterthesis Mobile Data/Projekte/Masterthesis Mobile Data/test2/test/Scripte aus Papers von Internetz/_3_A1305Schmid-1513071237090")
load("testdata.RData")

# Source Function ----------------------------------------------------------------------------------
source("FH-function-arcsin.R")

# Run Function -------------------------------------------------------------------------------------
fit<-FH_arcsin(y~x1+x2,dataframe_sample = data_sample, saind = data_sample$id,
                              dataframe_pop_aux = data_pop,x.total_saind = data_pop$id,
                              method=c("AP"), area_count = data_sample$effsample, Boot =T, 
                              B = 20,ratio = weights, bench_value = national_mean)

# Show Estimates -----------------------------------------------------------------------------------
# Small area point estimates 
fit$est_mean_FH

# Corresponding confidence intervals
fit$CI_FH

# Benchmarked small area point estimates 
fit$est_mean_FH_bench
