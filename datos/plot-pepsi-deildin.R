library('ggplot2')

classification <- read.csv('pepsi-deildin.csv',encoding="latin1")
ggplot(data=classification,aes(x=reorder(Team, -stig),y=stig))+geom_point()
ggplot(data=classification,aes(x=net,y=stig))+geom_point()
