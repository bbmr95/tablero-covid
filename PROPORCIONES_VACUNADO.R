library(dplyr)
library(tidyr)
library(tidyverse)
library(plotly)

casos_covid = read.csv("https://cloud.minsa.gob.pe/s/AC2adyLkHCKjmfm/download/positivos_covid.csv", sep=';')

labels = data.frame(lab = c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18),
                    eti = c('0-4','5-9','10-14','15-19','20-24','25-29','30-34','35-39','40-44','45-49','50-54','55-59','60-64','65-69','70-74','75-79','80+','SIN EDAD'))

nueva_base = ((casos_covid %>%
                 mutate(rango_edad = ifelse(EDAD >= 0 & EDAD <= 4, 1,
                                            ifelse(EDAD >= 5 & EDAD <= 9, 2,
                                                   ifelse(EDAD >= 10 & EDAD <= 14, 3,
                                                          ifelse(EDAD >= 15 & EDAD <= 19, 4,
                                                                 ifelse(EDAD >= 20 & EDAD <= 24, 5,
                                                                        ifelse(EDAD >= 25 & EDAD <= 29, 6,
                                                                               ifelse(EDAD >= 30 & EDAD <= 34, 7,
                                                                                      ifelse(EDAD >= 35 & EDAD <= 39, 8,
                                                                                             ifelse(EDAD >= 40 & EDAD <= 44, 9,
                                                                                                    ifelse(EDAD >= 45 & EDAD <= 49, 10,
                                                                                                           ifelse(EDAD >= 50 & EDAD <= 54, 11,
                                                                                                                  ifelse(EDAD >= 55 & EDAD <= 59, 12,
                                                                                                                         ifelse(EDAD >= 60 & EDAD <= 64, 13,
                                                                                                                                ifelse(EDAD >= 65 & EDAD <= 69, 14,
                                                                                                                                       ifelse(EDAD >= 70 & EDAD <= 74, 15,
                                                                                                                                              ifelse(EDAD >= 75 & EDAD <= 79, 16,
                                                                                                                                                     ifelse(EDAD >= 80, 17, 18))))))))))))))))))) %>% 
                mutate(rango_edad = replace_na(rango_edad,18))) %>%
  mutate(rango_edad = factor(rango_edad,labels$lab,labels$eti),
         FECHA_CORTE = as.Date(as.character(FECHA_CORTE), format = '%Y%m%d'),
         FECHA_RESULTADO = as.Date(as.character(FECHA_RESULTADO), format = '%Y%m%d')) %>%
  group_by(across(c(-id_persona,-EDAD))) %>%
  summarise(cant_p = n())






