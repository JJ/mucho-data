#!/usr/bin/env rscript
    
data.HI <- NULL  # create a place to save the URLs # change this line
data.HR <- NULL  # create a place to save the URLs # change this line
library(RCurl)
library(RJSONIO)
library(ggplot2)

alldata.HI <- data.frame(Date=as.Date(character()),
                          Views=character());
alldata.HR <- data.frame(Date=as.Date(character()),
                         Views=character());


for (year in (2010:2014)) {
    for (month in (1:12)) {
        
        theURL <- "http://stats.grok.se/json/is/"
        theURL <- paste0(theURL, year)
        
        if (month < 10) {
            theURL <- paste0(theURL, "0")
        }
        
        theURL <- paste0(theURL, month) 
        theURL.HR <- paste0(theURL, "/Háskólinn_í_Reykjavík")
        theURL.HI <- paste0(theURL, "/Háskóli_Íslands")
  

        # For hr
        rawData.hr <- getURL(theURL.HR)
        data.hr <- fromJSON(rawData.hr)
        df.HR <- data.frame(Date=names(data.hr$daily_views),Views=data.hr$daily_views)
        df.HR <-  df.HR[df.HR$Views > 0,]
        df.HR$Date <- as.Date(df.HR$Date)
        alldata.HR <- rbind( alldata.HR, df.HR )

        # For UA. I really have to learn functions or something
        rawData.HI <- getURL(theURL.HI)
        data.HI <- fromJSON(rawData.HI)
        df.HI <- data.frame(Date=names(data.HI$daily_views),Views=data.HI$daily_views)
        df.HI <-  df.HI[df.HI$Views > 0,]
        df.HI$Date <- as.Date(df.HI$Date)
        alldata.HI <- rbind( alldata.HI, df.HI )

    }
}
alldata.HI <- alldata.HI[order(alldata.HI$Date),]
alldata.HR <- alldata.HR[order(alldata.HR$Date),]

ggplot(data=alldata.HI,aes(x=Date,y=Views,group=1,col='HI'))+geom_line()+geom_line(data=alldata.HR,aes(x=Date,y=Views,group=1,col='HR'))
    ## END OF SCRIPT
