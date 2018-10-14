library(RCurl)
library(RJSONIO)
earthquake <- getURI('http://apis.is/earthquake/is')
qr <- fromJSON(earthquake)
size.num <- c(qr[[1]]$size1, qr[[2]]$size1, qr[[3]]$size[1], qr[[4]]$size, qr[[5]]$size, qr[[6]]$size, qr[[7]]$size, qr[[8]]$size, qr[[9]]$size, qr[[9]]$size, qr[[10]]$size,qr[[11]]$size, qr[[12]]$size, qr[[13]]$size, qr[[14]]$size)

