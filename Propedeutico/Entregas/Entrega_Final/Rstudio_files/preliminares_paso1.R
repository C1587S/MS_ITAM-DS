# cargamos os paquetes necesarios
packages <- c('devtools', 'RJSONIO', 'knitr', 'shiny', 'httpuv', 'plyr', 'WDI', 'tidyverse','googleVis')
new.packages <- packages[!(packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

# "require" nos da TRUE si se ecneuntra el paquete solicitado y falso si no (la usamos si queremos instalar paquetes necesarios)
require("devtools")
require("RJSONIO")
require("knitr")
require("shiny")
require("httpuv")
require("plyr") 
require("WDI")
require('ggvis')
require('tidyverse')
require('googleVis')

ls_nombres = c("Pib_per_capita_real", "Pib_per_capita_nom", "Pib_total", "Poblacion_total", "Esperanza_vida_nacer", 
               "Mortalidad_infantil", "Pobreza", "Acesso_sanitarios", "Electricidad_per_capita", "Prop_con_electricidad", "C02_tons")

ls_cods = c("NY.GDP.PCAP.KD", "NY.GDP.PCAP.CD", "NY.GDP.MKTP.CD", "SP.POP.TOTL", "SP.DYN.LE00.IN", "SP.DYN.IMRT.IN", "SI.POV.NAHC", "SH.STA.ACSN","EG.USE.ELEC.KH.PC", "EG.ELC.ACCS.ZS", "EN.ATM.CO2E.KT")

ppc_p10 <- WDI(indicator=ls_cods[1], country="all",start=1960, extra=T)
names(ppc_p10)[3] <- "Pib_per_capita_real"
ppc_pcor <- WDI(indicator=ls_cods[2], country="all",start=1960, extra=T)
names(ppc_pcor)[3] <- "Pib_per_capita_nom"
pib_tot <- WDI(indicator=ls_cods[3], country="all",start=1960, extra=T)
names(pib_tot)[3] <- "Pib_total"
pob_tot <-  WDI(indicator=ls_cods[4], country="all",start=1960, extra=T)
names(pob_tot)[3] <- "Poblacion_total"
e_vna <- WDI(indicator=ls_cods[5], country="all",start=1960, extra=T)
names(e_vna)[3] <- "Esperanza_vida_nacer"
m_inf <- WDI(indicator=ls_cods[6], country="all",start=1960, extra=T) 
names(m_inf)[3] <- "Mortalidad_infantil"
pobr <- WDI(indicator=ls_cods[7], country="all",start=1960, extra=T)
names(pobr)[3] <- "Pobreza"

# crear la base de datos agregada

parte_1 <- join(ppc_p10, ppc_pcor) 
parte_2 <- join(parte_1,pib_tot) 
parte_3 <- join(parte_2,pob_tot) 
parte_4 <- join(parte_3,e_vna) 
parte_5 <- join(parte_4, m_inf) 
parte_6 <- join(parte_5, pobr)
parte_7 <- join(parte_6, elec_ppc)
parte_8 <- join(parte_7, prop_elec)
big_db <- join(parte_8, co2_ton)

big_db_cln <- big_db %>% filter(region != "Aggregates")
big_db_nona <-na.omit(big_db_cln)








