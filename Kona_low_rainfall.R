library(tidyverse)
library(sf)
library(here)
library(mapview)

rainfall_data <- read.csv("~/Downloads/DS434-Spatial-Analysis/HCDP_data/rainfall/new/day/statewide/partial/station_data/2026/03/rainfall_new_day_statewide_partial_station_data_2026_03.csv")

###Explore
glimpse(rainfall_data)
summary(rainfall_data)
unique(rainfall_data)

rainfall_long <- rainfall_data %>%
  pivot_longer(
    cols = starts_with("X2026"),
    names_to = "date",
    values_to = "rainfall_mm"
  ) %>%
  mutate(date = as.Date(date, format = "X%Y.%m.%d"))

glimpse(rainfall_long)

##Animated Bubble Map: daily rainfall
library(gganimate)
library(gifski)

anim_data <- rainfall_long %>%
  filter(!is.na(rainfall_mm), !is.na(LAT), !is.na(LON))

anim <- ggplot(anim_data, aes(x = LON, y = LAT)) +
  geom_point(aes(size = rainfall_mm, color = rainfall_mm), alpha = 0.7) +
  scale_size_continuous(range = c(1, 15), name = "Rainfall (mm)") +
  scale_color_viridis_c(option = "turbo", name = "Rainfall (mm)") +
  coord_fixed(ratio = 1.2) +
  labs(
    title = "Daily Rainfall Across Hawaii – March 2026",
    subtitle = "Date: {frame_time}",
    x = "Longitude", y = "Latitude",
    caption = "Source: HCDP"
  ) +
  theme_minimal(base_size = 13) +
  theme(legend.position = "right") +
  transition_time(date) +
  ease_aes("linear")

animate(
  anim,
  nframes = 23,       # one frame per day
  fps = 2,            # slow enough to read each day
  width = 800,
  height = 500,
  renderer = gifski_renderer("hawaii_rainfall_march2026.gif")
)

library(rnaturalearth)
library(rnaturalearthdata)

hawaii_map <- ne_states(country = "united states of america", returnclass = "sf") %>%
  filter(name == "Hawaii")

anim <- ggplot() +
  geom_sf(data = hawaii_map, fill = "grey90", color = "grey50") +
  geom_point(data = anim_data,
             aes(x = LON, y = LAT, size = rainfall_mm, color = rainfall_mm),
             alpha = 0.7) +
  scale_size_continuous(range = c(1, 15), name = "Rainfall (mm)") +
  scale_color_viridis_c(option = "turbo", name = "Rainfall (mm)") +
  coord_sf(xlim = c(-160.5, -154.5), ylim = c(18.8, 22.4)) +
  labs(
    title = "Daily Rainfall Across Hawaii – March 2026",
    subtitle = "Date: {frame_time}",
    x = NULL, y = NULL,
    caption = "Source: HCDP"
  ) +
  theme_minimal(base_size = 13) +
  transition_time(date) +
  ease_aes("linear")

animate(
  anim,
  nframes = 23,
  fps = 2,
  width = 800,
  height = 500,
  renderer = gifski_renderer("hawaii_rainfall_march2026_basemap.gif")
)

##Extreme Event Map: cumulative storm total
storm_data <- rainfall_data %>%
  mutate(
    storm_total = rowSums(
      select(., X2026.03.13, X2026.03.14, X2026.03.15),
      na.rm = TRUE
    )
  ) %>%
  filter(!is.na(LAT), !is.na(LON))

storm_data <- storm_data %>%
  mutate(risk_tier = case_when(
    storm_total >= 300  ~ "Extreme (≥300mm)",
    storm_total >= 150  ~ "High (150–300mm)",
    storm_total >= 75   ~ "Moderate (75–150mm)",
    TRUE                ~ "Low (<75mm)"
  )) %>%
  mutate(risk_tier = factor(risk_tier, levels = c(
    "Low (<75mm)", "Moderate (75–150mm)", 
    "High (150–300mm)", "Extreme (≥300mm)"
  )))

storm_sf <- storm_data %>%
  st_as_sf(coords = c("LON", "LAT"), crs = 4326)

ggplot() +
  geom_sf(data = hawaii_map, fill = "grey90", color = "grey60") +
  geom_sf(data = storm_sf,
          aes(size = storm_total, color = risk_tier),
          alpha = 0.8) +
  scale_color_manual(
    values = c(
      "Low (<75mm)"        = "#2C7BB6",
      "Moderate (75–150mm)" = "#FED976",
      "High (150–300mm)"   = "#FD8D3C",
      "Extreme (≥300mm)"   = "#BD0026"
    ),
    name = "Risk Tier"
  ) +
  scale_size_continuous(range = c(2, 12), name = "Storm Total (mm)") +
  coord_sf(xlim = c(-160.5, -154.5), ylim = c(18.8, 22.4)) +
  labs(
    title = "Extreme Rainfall Event – Hawaii",
    subtitle = "Cumulative storm total: March 13–15, 2026",
    x = NULL, y = NULL,
    caption = "Source: HCDP | Thresholds based on NWS flash flood guidance"
  ) +
  theme_minimal(base_size = 13) +
  guides(size = "none")  # drop size legend, color tells the story

top_stations <- storm_data %>%
  slice_max(storm_total, n = 5)

# Add to the ggplot call:
geom_sf_label(data = st_as_sf(top_stations, coords = c("LON", "LAT"), crs = 4326),
              aes(label = paste0(Station.Name, "\n", round(storm_total), "mm")),
              size = 2.5, nudge_y = 0.05)

##Cumulative Saturation Animation: rainfall builds up at each station over the month
cumulative_data <- rainfall_long %>%
  filter(!is.na(rainfall_mm)) %>%
  arrange(Station.Name, date) %>%
  group_by(Station.Name, LAT, LON, Island) %>%
  mutate(cumulative_mm = cumsum(rainfall_mm)) %>%
  ungroup()

cumulative_data <- cumulative_data %>%
  mutate(sat_tier = case_when(
    cumulative_mm >= 500 ~ "Critical (≥500mm)",
    cumulative_mm >= 250 ~ "High (250–500mm)",
    cumulative_mm >= 100 ~ "Moderate (100–250mm)",
    TRUE                 ~ "Low (<100mm)"
  )) %>%
  mutate(sat_tier = factor(sat_tier, levels = c(
    "Low (<100mm)", "Moderate (100–250mm)",
    "High (250–500mm)", "Critical (≥500mm)"
  )))

cum_anim <- ggplot() +
  geom_sf(data = hawaii_map, fill = "grey90", color = "grey60") +
  geom_point(data = cumulative_data,
             aes(x = LON, y = LAT, size = cumulative_mm, color = sat_tier),
             alpha = 0.8) +
  scale_color_manual(
    values = c(
      "Low (<100mm)"        = "#2C7BB6",
      "Moderate (100–250mm)" = "#FED976",
      "High (250–500mm)"    = "#FD8D3C",
      "Critical (≥500mm)"   = "#BD0026"
    ),
    name = "Saturation Risk"
  ) +
  scale_size_continuous(range = c(1, 12), name = "Cumulative (mm)") +
  coord_sf(xlim = c(-160.5, -154.5), ylim = c(18.8, 22.4)) +
  labs(
    title = "Cumulative Rainfall Saturation – Hawaii",
    subtitle = "Date: {frame_time}",
    x = NULL, y = NULL,
    caption = "Source: HCDP | Saturation thresholds based on flash flood guidance"
  ) +
  theme_minimal(base_size = 13) +
  guides(size = "none") +
  transition_time(date) +
  ease_aes("linear")

animate(
  cum_anim,
  nframes = 23,
  fps = 2,
  width = 800,
  height = 500,
  renderer = gifski_renderer("hawaii_cumulative_saturation.gif")
)

cumulative_data %>%
  filter(date == as.Date("2026-03-23")) %>%
  ggplot() +
  geom_sf(data = hawaii_map, fill = "grey90", color = "grey60") +
  geom_point(aes(x = LON, y = LAT, size = cumulative_mm, color = sat_tier),
             alpha = 0.8) +
  scale_color_manual(
    values = c(
      "Low (<100mm)"        = "#2C7BB6",
      "Moderate (100–250mm)" = "#FED976",
      "High (250–500mm)"    = "#FD8D3C",
      "Critical (≥500mm)"   = "#BD0026"
    ),
    name = "Saturation Risk"
  ) +
  scale_size_continuous(range = c(2, 12), name = "Cumulative (mm)") +
  coord_sf(xlim = c(-160.5, -154.5), ylim = c(18.8, 22.4)) +
  labs(
    title = "Total Cumulative Rainfall – March 2026",
    subtitle = "End of month saturation snapshot",
    x = NULL, y = NULL,
    caption = "Source: HCDP"
  ) +
  theme_minimal(base_size = 13) +
  guides(size = "none")

## Open animated GIFs in browser
browseURL("hawaii_rainfall_march2026_basemap.gif")
browseURL("hawaii_cumulative_saturation.gif")

length(unique(anim_data$date))
library(transformr)

animate(
  anim,
  nframes = 23,
  fps = 2,
  width = 800,
  height = 500,
  renderer = av_renderer("hawaii_rainfall_march2026.mp4")
)

anim_save("hawaii_rainfall.gif", animation = last_animation())