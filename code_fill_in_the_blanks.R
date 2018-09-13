library(ggplot2) #Produces visual representations
library(tidycensus) #Loads US Census files and data for "tidyverse" and "sf"
library(tidyverse) #Supports "tidy" functions

#You can request your Census Key Here: https://api.census.gov/data/key_signup.html
census_api_key('Your Census Key Here', install=TRUE, overwrite=TRUE) #Authenticates the access to the API

# You can find a list of variables here: https://api.census.gov/data/2016/acs/acs5/variables.html
vars<-c("Count of Interest","Total from the same table") 

data <- get_acs(state = "State Abbreviation", geography = " See link below", variables = vars, geometry = TRUE, output="wide")

#State Abbreviations: https://www.50states.com/abbreviations.htm
#Geography: https://walkerke.github.io/tidycensus/articles/basic-usage.html#geography-in-tidycensus

#Here we start the production of the map
#Mutate Calculates the Percent of Interest
#ggplot is used to produce the map
#coord_sf is used to tell ggplot the state you are using following the EPSG Format
#ESPG Codes are available here: http://spatialreference.org/ref/epsg/ (in the search bar write the name of your state)
data %>%
  mutate(Percent = 100 * (Population Count/Total from the same Table))%>%
  ggplot(aes(fill = Percent, color = Percent)) + 
  geom_sf() + 
  coord_sf(crs =ESPG Code Here)+labs(caption="Caption Here",
                            title="Title Here",
                            subtitle="Subtitle here")

