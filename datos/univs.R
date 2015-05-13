#!/usr/bin/env rscript
    
data.US <- NULL  # create a place to save the URLs # change this line
data.UGR <- NULL  # create a place to save the URLs # change this line
library(RCurl)
library(RJSONIO)
library(ggplot2)

alldata.UGR <- data.frame(Date=as.Date(character()),
                          Views=character());
alldata.US <- data.frame(Date=as.Date(character()),
                         Views=character());


for (year in (2010:2014)) {
    for (month in (1:12)) {
        
        theURL <- "http://stats.grok.se/json/es/"
        theURL <- paste0(theURL, year)
        
        if (month < 10) {
            theURL <- paste0(theURL, "0")
        }
        
        theURL <- paste0(theURL, month) 
        theURL.us <- paste0(theURL, "/Universidad_de_Alicante")
        theURL.ugr <- paste0(theURL, "/Universidad_Miguel_Hernández")
  

        # For ugr
        rawData.ugr <- getURL(theURL.ugr)
        data.UGR <- fromJSON(rawData.ugr)
        df.UGR <- data.frame(Date=names(data.UGR$daily_views),Views=data.UGR$daily_views)
        df.UGR <-  df.UGR[df.UGR$Views > 0,]
        df.UGR$Date <- as.Date(df.UGR$Date)
        alldata.UGR <- rbind( alldata.UGR, df.UGR )

        # For US. I really have to learn functions or something
        rawData.us <- getURL(theURL.us)
        data.US <- fromJSON(rawData.us)
        df.US <- data.frame(Date=names(data.US$daily_views),Views=data.US$daily_views)
        df.US <-  df.US[df.US$Views > 0,]
        df.US$Date <- as.Date(df.US$Date)
        alldata.US <- rbind( alldata.US, df.US )

    }
}
alldata.US <- alldata.US[order(alldata.US$Date),]
alldata.UGR <- alldata.UGR[order(alldata.UGR$Date),]

ggplot(data=alldata.US,aes(x=Date,y=Views,group=1,col='US'))+geom_line()+geom_line(data=alldata.UA,aes(x=Date,y=Views,group=1,col='UMH'))
    ## END OF SCRIPT
