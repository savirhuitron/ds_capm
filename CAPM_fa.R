library(PerformanceAnalytics, warn = F)
library(dplyr, warn = F)
library(ggplot2, warn = F)
library(tidyr, warn = F)
library(reshape, warn = F)
library(quantmod, warn = F)
library(lubridate, warn =F)
library(rCharts)
library(DT, warn = F)


# c?digo en donde s?lo se realiza las Betas con el modelo lineal 

#carpeta <- 'C:/Users/Savir/Documents/CAPM'
#carpeta <- 'O:/Users/shuitrong/Documents/CAPM'
archivo1 <- 'muestra_ipc.csv'
archivo2 <- 'hist_ipc.csv'
archivo3 <- 'emisiones.csv'
archivo4 <- 'sector_ipc.csv'

# Lee los archivos
muestra <- read.csv(archivo1)
hist.ipc <- read.csv(archivo2)
emisiones <- read.csv(archivo3)
sector <- read.csv(archivo4)

muestra <- mutate(muestra, EMISION = paste0(EMISORA, SERIE))

precios <- mutate(emisiones, FECHA = as.Date(FECHA, format = '%Y-%m-%d')) %>% 
  cast(FECHA ~ EMISION, value = 'PA') 


ipc <- dplyr::mutate(hist.ipc, FECHA = as.Date(FECHA, format = '%d/%m/%Y')) %>% 
  dplyr::select(c(-INDICE)) %>% 
  dplyr::rename(IPC = NIVEL)

nombres <- names(precios)
muestra1 <- as.vector(muestra$EMISION)

# valida cuales de las emisiones del IPC se encuentran  en los precios ajustados 
# las guardamos en un vector para filtrarlos por la posicion en la cual se quedan 

emis <- which (nombres %in% muestra1 == TRUE) 

t4 <- dplyr::select(precios, FECHA)

for (i in emis){
  
  t1 <- dplyr::select(precios, i)
  
  t4 <- cbind(t4, t1)
  
}

t4 <- dplyr::select(t4, -c(NEMAKA))

t6 <- merge(t4, ipc, by = "FECHA" )

######

# realiza los rendimientos 

t5 <- sapply(t6[,2:length(t6)], Delt)

# Elimina la primer fila de los rendimientos. 

t5 <- t5[-1, ]

rend <- as.data.frame(t5)

# adjuntamos en esta base el indice

# Realizamos el data frame que contenga las betas

b <- data.frame()

for (i in 1:length(rend)){
  
  a <- dplyr::select(rend, i, IPC)
  
  beta <- lm(a[,1] ~ IPC, data = a)
  b1 <- beta$coefficients[2]
  
  b <- rbind(b,b1)
  
}

colnames(b) <- "BETA"

rf <- 3.5/100
rm <- 8.29/100

b1 <-  dplyr::mutate(b, EMISION = names(rend)) %>% 
  dplyr::select(EMISION,BETA) %>% 
  dplyr::mutate(RF = rf, RM = rm, CAPM = (RF + BETA *(RM - RF)* 100), 
                EMISORA = 1:length(rend))

# Las podemos dividir en quartiles / primero realizamos un vector el cual contenga 
# el numero de emisoras 

niveles <- 1:nrow(b1)

# idenificamos los cuartiles   Alta, baja, media y minima

q <- quantile(b1$BETA)

minima  <-   which(b1$BETA <= quantile(b1$BETA)[2])
baja   <-   which(b1$BETA > quantile(b1$BETA)[2] &  b1$BETA <= quantile(b1$BETA)[3])
media    <-   which(b1$BETA > quantile(b1$BETA)[3] &  b1$BETA <= quantile(b1$BETA)[4])
alta    <-   which(b1$BETA > quantile(b1$BETA)[4])

# realizamos la comprobaci?n de las emisoras
length(alta) + length(media) + length(minima) + length(baja)

niveles[minima] <- "MINIMUM"
niveles[baja] <- "LOW"
niveles[media] <- "MEDIA"
niveles[alta] <- "HIGH"

b2 <- dplyr::mutate(b1, NIVELES = niveles, BETA = round(BETA, 6), CAPM = round(CAPM, 6))

# Desde aqui realizamos visualizaciones


# Data Table para que se vea la informacion correspondiente 

b3 <- dplyr::select(b2, -c(EMISORA))


# Integramos los sectores para saber quienes son 

b4 <- merge(b3, sector, by.x =  "EMISION") %>% 
      select(EMISION, RF, RM, BETA, CAPM, NIVELES, SECTOR, NIVELES)

b4 <- datatable(b4,rownames = F)

b7 <- b3 %>% 
  mutate(RF1 = (3.5/100), RM1 = (8.29/100), CAPM1 = (RF1 + BETA*(RM1 - RF1)*100))


# Pie que nos dice las emisoras del IPC que pertenecen a los distintos SECTORES


hota <- as.data.frame(table(sector$SECTOR_EN)) 

ja <- as.vector(hota[6,1])

hota <- dplyr::filter(hota, Var1 != hota[6,1])    


hist <- group_by(sector, SECTOR_EN) %>% 
  summarise(MKT_CAP = sum(VMKT_USD)/1000000) %>% 
  arrange(desc(MKT_CAP))

