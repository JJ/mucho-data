require(httr)
require(RJSONIO)
 

url <- "http://px.hagstofa.is/pxis/api/v1/is/Atvinnuvegir/ferdathjonusta/farthegar/SAM02001.px"

check <- GET(url)
# I think I need to put the query stuff in tye body?! But have no clue how … it needs to be a POST request to get the data…

data <- list(query = c(list( code = 'Ríkisfang'),list( code='Ár')), response= list( format = 'csv'))
response <- POST(url=url, body=data,format='json')

