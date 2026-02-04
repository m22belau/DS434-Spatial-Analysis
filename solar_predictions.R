library(here)
library(sf)

solar_predictions <- st_read(here("oahu_solar_preliminary.geojson"))

head(my_geojson)

str(my_geojson)

print(my_geojson)

dim(my_geojson)

library(ggplot2)

ggplot(data = solar_predictions, aes(x = score)) +
  geom_histogram()

total_area <-sum(solar_predictions$area_m2)
  total_area
  
