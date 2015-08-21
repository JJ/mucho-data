#!/usr/bin/env rscript
    
data.UA <- NULL  # create a place to save the URLs # change this line
data.UMH <- NULL  # create a place to save the URLs # change this line
library(RCurl)
library(RJSONIO)
library(ggplot2)

alldata.UMH <- data.frame(Date=as.Date(character()),
                          Views=character());
alldata.UA <- data.frame(Date=as.Date(character()),
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
        data.UMH <- fromJSON(rawData.ugr)
        df.UMH <- data.frame(Date=names(data.UMH$daily_views),Views=data.UMH$daily_views)
        df.UMH <-  df.UMH[df.UMH$Views > 0,]
        df.UMH$Date <- as.Date(df.UMH$Date)
        alldata.UMH <- rbind( alldata.UMH, df.UMH )

        # For UA. I really have to learn functions or something
        rawData.us <- getURL(theURL.us)
        data.UA <- fromJSON(rawData.us)
        df.UA <- data.frame(Date=names(data.UA$daily_views),Views=data.UA$daily_views)
        df.UA <-  df.UA[df.UA$Views > 0,]
        df.UA$Date <- as.Date(df.UA$Date)
        alldata.UA <- rbind( alldata.UA, df.UA )

    }
}
alldata.UA <- alldata.UA[order(alldata.UA$Date),]
alldata.UMH <- alldata.UMH[order(alldata.UMH$Date),]

ggplot(data=alldata.UA,aes(x=Date,y=Views,group=1,col='UA'))+geom_line()+geom_line(data=alldata.UA,aes(x=Date,y=Views,group=1,col='UMH'))
    ## END OF SCRIPT
