library(ggplot2) #Produces visual representations
library(tidycensus) #Loads US Census files and data for "tidyverse" and "sf"
library(tidyverse) #Supports "tidy" functions

#You can request your Census Key Here: https://api.census.gov/data/key_signup.html
census_api_key('Your Census Key Here', install=TRUE, overwrite=TRUE) #Authenticates the access to the API

vars<-c("B05001_001E","B05001_006E") #Number of Citizens and Total Pop by County

penns <- get_acs(state = "PA", geography = "county", variables = vars, geometry = TRUE, output="wide")

penns %>%
  mutate(Percent = 100 * (B05001_006E / B05001_001E))%>%
  ggplot(aes(fill = Percent, color = Percent)) + 
  geom_sf() + 
  coord_sf(crs = 2271)+labs(caption="ACS 2012-2016 ACS, by Alexis R. Santos",
                            title="Percent non-citizen population by County in Pennsylvania",
                            subtitle="Produced using the Census API and R")