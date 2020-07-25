install.packages("sf")
install.packages("ggplot2")
install.packages("ggmap")
install.packages("mapview")
install.packages("leaflet")
install.packages("RColorBrewer")
install.packages("ggspatial")
install.packages("sp")
install.packages("raster")
install.packages("rgdal")
library(sf)
library(ggplot2)
library(ggmap)
library(mapview)
library(leaflet)
library(RColorBrewer)
library(ggspatial)
library(sp)
library(rgdal)


range_veg_type_crop <- st_crop(range_veg_transformed, extent(county_boundary_transformed))






#read in the layers from shapefiles
land_polygon <- st_read("/Users/devinhagan/Downloads/GIS Data Summer 2020/LandPolygon/geo_export_9e6674d8-0ad3-4606-b969-cbe2baebf8aa.shp") #where are these layers from
county_boundary <- st_read("/Users/devinhagan/Downloads/GIS Data Summer 2020/County_Boundary__line_-shp/County_Boundary__Line_.shp")
development_activity <- st_read("/Users/devinhagan/Downloads/GIS Data Summer 2020/Planning_Office_Data_Service2-shp/Development_Activity.shp")
fire_protection <- st_read("/Users/devinhagan/Downloads/GIS Data Summer 2020/Fire_Protection_Districts-shp/Fire_Protection_Districts.shp")
urban_reserve_interface <- st_read("/Users/devinhagan/Downloads/GIS Data Summer 2020/Urban-Reserve_System_Interface_Zones-shp/Urban___Reserve_System_Interface_Zones.shp")
zoning <- st_read("/Users/devinhagan/Downloads/GIS Data Summer 2020/Zoning-shp/Zoning.shp")
fire_hazard <- st_read("/Users/devinhagan/Downloads/fhszs43sn/fhszs06_3_43.shp")
cities <- st_read("/Users/devinhagan/Downloads/GIS Data Summer 2020/City_Spheres_of_Influence-shp/Spheres_of_Influence.shp")
water <- st_read("/Users/devinhagan/Downloads/GIS Data Summer 2020/Water_Districts_Spheres_of_Influence-shp/Water_Districts_SOI.shp")
range_veg_types <- st_read("/Users/devinhagan/Downloads/Rangeland 4/All_grazing_VegTypes_081114.shp")
solar_power_plant <- st_read("/Users/devinhagan/Downloads/GIS Data Summer 2020/California_Power_Plants-shp/6decc5aa-b0ac-4c30-a9e0-ac442c62b6cd2020328-1-1qz24o4.gqjg.shp")
general_plan_zoning <- st_read("/Users/devinhagan/Downloads/GIS Data Summer 2020/General Plan/geo_export_e6478d4e-a14b-4ea1-933a-5fbbb9f219b5.shp")







pdf("land_parcel_polygons.pdf")
ggplot () +
  geom_sf(data = county_boundary, color = 'black', lwd = 0.2) +
  geom_sf(data = cities, fill = 'darkgrey') +
  geom_sf(data = general_plan_zoning, aes(fill = gen_plan), color = 'black', lwd = 0.15) +
  geom_sf(data = land_polygon, color = 'red', fill = NA, lwd = 0.05) 
dev.off()

pdf("general_plan_fire_hazard.pdf")
ggplot () +
  geom_sf(data = county_boundary, color = 'black', lwd = 0.5) +
  geom_sf(data = cities, fill = 'darkgrey', color = 'black', lwd = 0.25) +
  geom_sf(data = fire_hazard, aes(fill = HAZ_CLASS), color = NA) +
  scale_fill_brewer(palette = "YlOrRd", name = "Fire Hazard Severity Zones") +
  geom_sf(data = general_plan_zoning, aes(color = gen_plan), fill = NA, lwd = 0.4)
dev.off()  













pdf("general_plan_zoning.pdf")
par(mfrow = c(1,1))
ggplot() +
  geom_sf(data = county_boundary, color = 'black', lwd = 0.2) +
  geom_sf(data = general_plan_zoning, aes(fill = gen_plan), color = 'black', lwd = 0.15)
dev.off()


#create map showing land parcels of Santa Clara with development activity and fire protection districts
par(mfrow = c(1,1))
ggplot() + 
  geom_sf(data = county_boundary, color = 'lightblue', lwd = 0.5) + 
  geom_sf(data = development_activity, color = 'burlywood4', fill = 'burlywood4', lwd = 0.2) +
  geom_sf(data = land_polygon, color = 'lightblue', fill = NA, lwd = 0.05) +
  geom_sf(data = fire_protection, color = 'orange', fill = 'orange', lwd = 0.2)


#create map showing land parcels of Santa Clara with development activity and urban reserve interface layers
par(mfrow = c(1,1))
ggplot() + 
  geom_sf(data = county_boundary, color = 'black', lwd = 0.2) +
  geom_sf(data = development_activity, color = 'burlywood4', fill = 'burlywood4') +
  geom_sf(data = urban_reserve_interface, color = 'red', fill = 'red') +
  geom_sf(data = land_polygon, color = 'lightblue', fill = NA, lwd = 0.05) 


#just creating some rough plots and saving them to a pdf file
pdf("Plots.pdf")
par(mfrow = c(1,3))
ggplot() + 
  geom_sf(data = county_boundary, color = 'black', lwd = 0.2) +
  geom_sf(data = development_activity, color = 'burlywood4', fill = 'burlywood4')
ggplot() + 
  geom_sf(data = county_boundary, color = 'black', lwd = 0.2) +
  geom_sf(data = development_activity, color = 'burlywood4', fill = 'burlywood4') +
  geom_sf(data = urban_reserve_interface, color = 'red', fill = 'red') 
ggplot() + 
  geom_sf(data = county_boundary, color = 'black', lwd = 0.2) +
  geom_sf(data = development_activity, color = 'burlywood4', fill = 'burlywood4') +
  geom_sf(data = urban_reserve_interface, color = 'red', fill = 'red') +
  geom_sf(data = land_polygon, color = 'lightblue', fill = NA, lwd = 0.005) 
dev.off()
  
#county map with just devlopment activity
par(mfrow = c(1,1))
ggplot() + 
  geom_sf(data = county_boundary, color = 'black', lwd = 0.2) +
  geom_sf(data = development_activity, color = 'burlywood4', fill = 'burlywood4') +
  geom_sf(data = zoning, aes(color = actualZone), fill = NA)
  

#Zoning maps and fire hazard severity zones

#assign the zones with a better descriptor for legend key
zoning$actualZone[zoning$BaseZone == 'A'] <- 'Exclusive Agriculture'
zoning$actualZone[zoning$BaseZone == 'AR'] <- 'Agricultural Rangelands'
zoning$actualZone[zoning$BaseZone == 'HS'] <- 'Hillsides'
zoning$actualZone[zoning$BaseZone == 'RR'] <- 'Rural Residential'
zoning$actualZone[is.na(zoning$actualZone)] <- 'Non Rural Based District'

#level the classes so that they go in logical order
fire_hazard$HAZ_CLASS <- factor(fire_hazard$HAZ_CLASS, levels = c("Moderate", "High", "Very High"))
zoning$actualZone <- factor(zoning$actualZone, levels = c('Exclusive Agriculture','Agricultural Rangelands', 'Hillsides', 'Rural Residential', 'Non Rural Based District'))

#fire hazard zones and RBD on top
pdf("FireZoning.pdf")
par(mfrow = c(1,2))
ggplot()+
  geom_sf(data = county_boundary, color = 'black', lwd = 0.2) +
  geom_sf(data = fire_hazard, aes(fill = HAZ_CLASS)) +
  scale_fill_brewer(palette = "YlOrRd")
ggplot() +
  geom_sf(data = county_boundary, color = 'black', lwd = 0.2) +
  geom_sf(data = zoning, aes(fill = actualZone)) 
dev.off()

  


#SCC fire hazard zones and RBD 
pdf("FireZoningCities.pdf")
par(mfrow =c(1,1))
ggplot() +
  geom_sf(data = county_boundary, color = 'black', lwd = 0.2) +
  geom_sf(data = cities, fill = 'darkgrey') +
  geom_sf(data = fire_hazard, aes(fill = HAZ_CLASS)) +
  scale_fill_brewer(palette = "YlOrRd", name = "Fire Hazard Severity Zones") +
  geom_sf(data = water, fill = 'lightblue') +
  geom_sf(data = zoning, aes(color = actualZone), fill = NA) + 
  scale_color_brewer(palette = "Paired", name = "Rural Based Districts") +
  geom_sf_text(data = cities, aes(label = SOI, geometry = geometry), color = 'white', check_overlap = TRUE, size = 2.5) + 
  ggtitle("Santa Clara County", subtitle = "Fire Hazard Severity Zones and Rural Based Districts") + 
  theme(axis.title.x = element_blank(), axis.title.y = element_blank(), axis.text.x = element_blank(), axis.text.y = element_blank(), axis.ticks = element_blank()) +
  annotation_scale(location = "bl") + # scale bar in the bottom left corner 
  annotation_north_arrow(location = "bl", which_north = "true", pad_x = unit(2, "cm"), pad_y = unit(1, "cm"), height = unit(1, "cm"))  # north arrow
dev.off()



#just the cities and bodies of water
par(mfrow =c(1,1))
ggplot() +
  geom_sf(data = county_boundary, color = 'black', lwd = 0.2) +
  geom_sf(data = cities, fill = 'darkgrey') +
  geom_sf(data = water, fill = 'lightblue') + 
  geom_sf_text(data = cities, aes(label = SOI, geometry = geometry), color = 'white', check_overlap = TRUE, size = 3)




#land cover layer with zoning on top, for some reason the land cover does not take up whole county
pdf("LandCover.pdf", width = 20, height = 10)
ggplot() +
  geom_sf(data = county_boundary, color = 'black', lwd = 0.2) +
  geom_sf(data = land_cover_layer,aes(fill = land_cover)) +
  #geom_sf(data = zoning, aes(color = actualZone), fill = NA) + 
  scale_color_brewer(palette = "Set1", name = "Rural Based Districts")
dev.off()  




#rangeland vegetation type (Sheila data), with zoning underlying
pdf("RangeVegType.pdf", width = 20, height = 10)
par(mfrow = c(1,2))
ggplot() + 
  geom_sf(data = county_boundary, color = 'black', lwd = 0.5) +
  geom_sf(data = cities, fill = 'darkgrey', color = NA) +
  geom_sf(data = zoning, aes(fill = actualZone), color = NA) + 
  scale_fill_brewer(palette = "Pastel2", name = "Rural Based Districts") 


ggplot() +
  geom_sf(data = county_boundary, color = 'black', lwd = 0.5) +
  geom_sf(data = cities, fill = 'darkgrey', color = NA) +
  geom_sf(data = zoning, aes(fill = actualZone), color = NA) + 
  scale_fill_brewer(palette = "Pastel2", name = "Rural Based Districts") +
  geom_sf(data = range_veg_types, aes(color = Graz_Categ), fill = NA, lwd = 0.1) +
  scale_color_brewer(palette = "Set1", name = "Grazing Category")
dev.off()



#rangeland veg type with fire hazard zones underlying
pdf("RangeVegFireHaz.pdf", width = 20, height = 10)
par(mfrow = c(1,2))
ggplot() +
  geom_sf(data = county_boundary, color = 'black', lwd = 0.5) +
  geom_sf(data = cities, fill = 'darkgrey', color = NA) +
  geom_sf(data = fire_hazard, aes(fill = HAZ_CLASS), color = NA) +
  scale_fill_brewer(palette = "YlOrRd", name = "Fire Hazard Severity Zones") 


ggplot() +
  geom_sf(data = county_boundary, color = 'black', lwd = 0.5) +
  geom_sf(data = cities, fill = 'darkgrey', color = NA) +
  geom_sf(data = fire_hazard, aes(fill = HAZ_CLASS), color = NA) +
  scale_fill_brewer(palette = "YlOrRd", name = "Fire Hazard Severity Zones") +
  geom_sf(data = range_veg_types, aes(color = Graz_Categ), fill = NA, lwd = 0.03) +
  scale_color_brewer(palette = "Dark2", name = "Grazing Category")
dev.off()


#rangeland veg type with development activity underlying
pdf("RangeVegDevelopment.pdf", width = 20, height = 10)
par(mfrow = c(1,2))
ggplot() +
  geom_sf(data = county_boundary, color = 'black', lwd = 0.5) +
  geom_sf(data = cities, fill = 'darkgrey', color = NA) +
  geom_sf(data = development_activity, color = 'burlywood4', fill = 'burlywood4') 


ggplot() +
  geom_sf(data = county_boundary, color = 'black', lwd = 0.5) +
  geom_sf(data = cities, fill = 'darkgrey', color = NA) +
  geom_sf(data = development_activity, color = 'burlywood4', fill = 'burlywood4') +
  geom_sf(data = range_veg_types, aes(color = Graz_Categ), fill = NA, lwd = 0.03) 
dev.off()



#converting Cal Lands file into a shapefile and then reading in shapefile to plot map
library(raster)
shapefile(x = county, file = "/Users/devinhagan/Downloads/06085.shp")

county_shapefile <- st_read("/Users/devinhagan/Downloads/06085.shp")

ggplot()+
  geom_sf(data = county_shapefile, color = 'red', lwd = 0.5)






# Transform shapefiles to my projection 
range_veg_transformed <- st_transform(range_veg_types, crs=4326)
range_veg_transformed <- st_transform(range_veg_types, crs=4326)
county_boundary_transformed <- st_transform(county_boundary, crs = 4326)



# Crop the transformed files
range_veg_type_cropped <- st_crop(range_veg_types, xmin = -120.35, xmax = -120.3, ymin = 39.7, ymax = 39.75) 
