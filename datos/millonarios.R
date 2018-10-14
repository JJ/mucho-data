library(ggplot2)
library(ggthemes)

datos <- read.csv("millonarios.dat",sep=";")
ggplot(datos,aes(x=reorder(Nombre,-Peso),y=Peso,color=Posición))+ geom_point()+theme_tufte()+theme(axis.text.x = element_text(angle = 90, hjust = 1))+xlab("Jugador")
ggplot(datos,aes(x=reorder(Nombre,-Altura),y=Altura,color=Posición))+ geom_point()+theme_tufte()+theme(axis.text.x = element_text(angle = 90, hjust = 1))+xlab("Jugador")
