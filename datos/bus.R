library(RCurl)
library(RJSONIO)

theBus <- "11"
theURL <- paste0("http://apis.is/bus/realtime?busses=",theBus)
rawData <- getURL(theURL)
bus.data <- fromJSON(rawData)
print(bus.data)
