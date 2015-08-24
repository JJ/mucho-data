library("pxR")
library("ggplot2")

tourism.is<- read.px( "tourism-is.px" )
tourism.is.data   <-  as.data.frame( tourism.is )
tourism.is.data$Year <- as.integer(tourism.is.data$Year)
tourism.is.data.domestic <- tourism.is.data[tourism.is.data$Type.of.tourism=="Inbound tourism",]
domestic.trips <- tourism.is.data.domestic[tourism.is.data.domestic$Activity=="Number of trips",]
ggplot(data=domestic.trips, aes(x=Year,y=value))+geom_line()
