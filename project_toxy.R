library(rgdal)
library(sp)

data<- read.csv("6_PSRC2015_GPS_Location.csv")

cord <-  data.frame(lon=data$lon,lat=data$lat)

#read coordinates
coordinates(cord) <- ~ lon + lat
#set the ref to GCS_North_American_1983_HARN
proj4string(cord) <- CRS("+init=epsg:4269") 
# converted to NAD_1983_HARN_StatePlane_Washington_North_FIPS_4601_Feet
proj <- spTransform(cord, CRS("+init=epsg:2926"))
# msglace long/lat to x/y in data
data$lon<- proj@coords[,"lon"]
data$lat<- proj@coords[,"lat"]
head(proj@coords)


write.csv(data,"xy/6_PSRC2015_GPS_Location.csv")


#for data has missing coordinates 
# cord <- cord[!is.na(cord$lon),]
# data <- left_join(data,data.frame(proj),by=c("hhid"="data.hhid"))