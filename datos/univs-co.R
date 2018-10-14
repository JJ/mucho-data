#!/usr/bin/env rscript
    
data.CUN <- NULL  # create a place to save the URLs # change this line
data.UN <- NULL  # create a place to save the URLs # change this line
library(RCurl)
library(RJSONIO)
library(ggplot2)

rawData.ugr <- getURL("https://wikimedia.org/api/rest_v1/metrics/pageviews/per-article/es.wikipedia/all-access/all-agents/Universidad_Nacional_de_Colombia/monthly/2015100100/201810100")
data.UN <- fromJSON(rawData.ugr)$items
df.UN <- data.frame(matrix(unlist(data.UN),nrow=36, byrow=T))
df.UN$Views <-  as.numeric(levels(df.UN$X7))[df.UN$X7]
df.UN$Date <-  as.Date(df.UN$X4,"%Y%m%d00")

                                        # For CUN. I really have to learn functions or something
rawData.us <- getURL("https://wikimedia.org/api/rest_v1/metrics/pageviews/per-article/es.wikipedia/all-access/all-agents/Corporaci%C3%B3n_Unificada_Nacional_de_Educaci%C3%B3n_Superior/monthly/2015100100/201810100")

data.CUN <- fromJSON(rawData.us)
df.CUN <- data.frame(matrix(unlist(data.CUN),nrow=36, byrow=T))
df.CUN$Views <-   as.numeric(levels(df.CUN$X7))[df.CUN$X7]
df.CUN$Date <-  as.Date(df.CUN$X4,"%Y%m%d00")

ggplot(data=df.CUN,aes(x=Date,y=Views,group=1,col='CUN'))+geom_line()+geom_line(data=df.UN,aes(x=Date,y=Views,group=1,col='UN'))
    ## END OF SCRIPT
