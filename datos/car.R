library(RCurl)
library(RJSONIO)

theCar <- "AA031"
theURL <- paste0("http://apis.is/car?number=",theCar)
rawData <- getURL(theURL)
car.data <- fromJSON(rawData)
print(car.data)
