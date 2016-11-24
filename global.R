
#Global file for global variable declarations

#for data Boston
library(MASS)
library(ggvis)
library(tidyverse)

#converting to tibble
boston_data <- tbl_df(Boston)


#predictor variable names
new_names <- c("Crime Rate" = "crim", "Land Zoned" = "zn", 
               "Industrial Area acres per town" = "indus", 
               "Nitrogen Oxide Concentration(parts per 10 million)" = "nox", 
               "Average number of rooms per dwelling" = "rm", 
               "Age of Houses (calculated since 1940)" = "age", 
               "Mean of distances from employment sectors" = "dis", 
               "Accessibility to radial highways" = "rad", 
               "Property Tax per 10000USD" = "tax", 
               "Pupil-Teacher ratio" = "ptratio", 
               "Indicator of Percentage of Black Population" = "black", 
               "Lower status of the population (percent)" = "lstat", 
               "Median value of owner-occupied homes(1000USD)" = "medv")
