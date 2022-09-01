# Multinomial Regression 
install.packages("mlogit")

data(package = "mlogit")
library(mlogit)
library(tidyverse)

data("Fishing", package = "mlogit")

fishing_data <- mlogit.data(data = Fishing, choice = "mode",  shape = "wide")
fishing_data

logit <- mlogit(mode ~ 1|income, data = fishing_data, reflevel = "pier")
summary(logit)

###making predictions 

fishing.dat <- subset(fishing_data, mode == "TRUE")
fishing.dat2 <- predict(logit, newdata = fishing_data)
fishing.dat
fishing.dat2

## checking the number of rows in both data
nrow(fishing.dat)
nrow(fishing.dat2)

### combining this two dataframes
outcomes <- cbind(fishing.dat, fishing.dat2)
outcomes
totals<- aggregate(cbind(outcomes$beach, outcomes$boat, outcomes$charter,
                outcomes$pier), by = list(income = outcomes$income),FUN = sum )

### renaming the fields
names(totals)[names(totals) == "V1"] <- "Beach"
names(totals)[names(totals) == "V2"] <- "Boat"
names(totals)[names(totals) == "V3"] <- "Character"
names(totals)[names(totals) == "V4"] <- "Pier"
totals
