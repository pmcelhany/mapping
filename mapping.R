#maps for OA projects

library(tmap)
library(tmaptools)
library(sf)
library(ggplot2)
library(geosphere)
library(rnaturalearth)


setwd("/Users/paul.mcelhany/Downloads/map shape files")
#data sets from http://www.naturalearthdata.com/downloads/10m-physical-vectors/
land <- st_read("ne_10m_land/ne_10m_land.shp")
smallIslands <- st_read("ne_10m_minor_islands/ne_10m_minor_islands.shp")

#oceans <- st_read("ne_10m_ocean/ne_10m_ocean.shp")
dSites <- read.csv("SampleSites.csv", stringsAsFactors = FALSE)
sites_sf <- st_as_sf(dSites[dSites$type == "collection",], coords = c("Lon", "Lat"), crs = 4326)
lab_sf <- st_as_sf(dSites[dSites$type == "lab",], coords = c("Lon", "Lat"), crs = 4326)

detailExtent <- st_bbox(c(xmin = -125.5, xmax = -121.5, ymin = 46.75, ymax = 50))
extent <- detailExtent
m <- tm_shape(land, bbox = extent) +
  tm_polygons() +
  tm_grid(labels.size = 1) +
  tm_scale_bar(, text.size = 1) +
  tm_layout(bg.color="lightskyblue") +
  tm_shape(smallIslands, bbox = extent) +
  tm_polygons() +
  tm_shape(sites_sf) + 
  tm_dots(size = 1, col = "red") +
  tm_text("Site", size = 1, just = "left", ymod = 0, xmod = 1) +
  tm_shape(lab_sf) + 
  tm_dots(size = 1, col = "black") +
  tm_text("Site", size =1, just = "top", ymod = -1, xmod = 0)

m

tmap_save(m, "detailSiteMap.jpeg")


largeExtent <- st_bbox(c(xmin = -145, xmax = -110, ymin = 30, ymax = 70))
extent <- largeExtent
m <- tm_shape(land, bbox = extent) +
  tm_polygons() +
  tm_grid(labels.size = 1) +
  tm_layout(bg.color="lightskyblue") +
  tm_shape(sites_sf) + 
  tm_dots(size = 1, col = "red")

m

tmap_save(m, "largeSiteMap.jpeg")


veryDetailedExtent <- st_bbox(c(xmin = -122.793000, xmax = -122.510569, ymin = 48.669400, ymax = 48.890818))
extent <- veryDetailedExtent
m <- tm_shape(land, bbox = extent) +
  tm_polygons() +
  tm_scale_bar(, text.size = 1) +
  tm_layout(bg.color="lightskyblue") +
  tm_shape(smallIslands, bbox = extent) +
  tm_polygons() +
  tm_shape(sites_sf) + 
  tm_dots(size = 1, col = "red") +
  tm_text("Site", size = 1, just = "left", ymod = 0, xmod = 1)

m

tmap_save(m, "veryDetailSiteMap.jpeg")

halesLonLat <- c(dSites$Lon[dSites$Site == "Hale's Pass"], dSites$Lat[dSites$Site == "Hale's Pass"])
halesShore <- c(-122.663287, 48.729301)
sandyLonLat <- c(dSites$Lon[dSites$Site == "Sandy Point"], dSites$Lat[dSites$Site == "Sandy Point"])
sandyShore <- c(-122.709052, 48.816226)
distHalesSandy <- distm(halesLonLat, sandyLonLat, fun = distHaversine)/1000
distHalesShore <- distm(halesLonLat, halesShore, fun = distHaversine)
distSandyShore <- distm(sandyLonLat, sandyShore, fun = distHaversine)
















