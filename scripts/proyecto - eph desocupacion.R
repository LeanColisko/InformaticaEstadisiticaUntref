# TASA DE DESOCUPACIÓN ----------------------------------
library(eph)
library(dplyr)

#Eliminamos todos los objetos creados en el global environment
rm(list = ls())

#Carga de tabla de individuos
df_eph <- get_microdata(year = 2020, #Año 
                        trimester = 4, #Trimestre
                        type = "individual")

hogares <- get_microdata(year = 2020, #Año 
                        trimester = 4, #Trimestre
                        type = "hogar") 


# Etiquetas a los valores
individuos_trans <- df_eph %>% 
  organize_labels(type = "individual") #Pegamos las etiquetas
 


# Selección de variables y filtro de estado (Ocupados, desocupados, inactivos)
individuos_trans <- df_eph %>% 
  select(REGION, PONDERA, CH04, ESTADO) %>% 
  filter(ESTADO %in% c("1","2")) 

# operador: %in%
#ESTADO == 1 | ESTADO == 2 


# Tasa de Desocupación Nacional 
# Tasa de desocupación a nivel nacional
individuos_trans %>% 
  summarise(PEA = sum(PONDERA), #Calculamos la PEA
            desocupados = sum(PONDERA[ ESTADO == 2 ]), # Cantidad de desocupados
            tasa_desocupados = (desocupados/PEA) * 100 #Calculamos la Tasa de Desocupación
            ) 


# Tasa por sexo
tasa_sexo <- individuos_trans %>% 
  group_by(CH04) %>% 
  summarise(PEA = sum(PONDERA), #Calculamos la PEA
            desocupados = sum(PONDERA[ ESTADO == 2 ]), #Calculamos los desocupados
            tasa_desocupados = desocupados / PEA*100)   #Calculamos la Tasa de Desocupación


# Tasa por region
tasa_region <- individuos_trans %>% 
  group_by( REGION ) %>% 
  summarise(PEA = sum(PONDERA), #Calculamos la PEA
            desocupados=sum(PONDERA[ESTADO==2]), #Calculamos los desocupados
            tasa_desocupados = desocupados/PEA*100) %>% #Calculamos la Tasa de Desocupación
  organize_labels("hogar")

tasa_region %>% 
  mutate(REGION = factor(REGION))




library(ggplot2)
# Agregando capas en ggplot
g <- ggplot(data = tasa_region, aes(x = reorder(factor(REGION), desc(tasa_desocupados)), 
                               y = tasa_desocupados)) +
  geom_col(fill = '#66FF66') 

g <- g +
  geom_label(aes(label = sprintf('%.2f%%',tasa_desocupados))) 

g <- g + 
  labs(title = "Tasa de desocupación por región",
       caption = "EPH: cuarto trimestre año 2020", 
       x = NULL, y=NULL) 
  

g <- g +   
  theme_minimal() +
  theme(plot.title = element_text(size = 14, face = "bold", hjust = 0.5),  
        plot.caption = element_text(size = 10, face = "bold.italic"))

# Imprimimos el gráfico
g



#Tasa de desocupación por región y sexo
tasa_des_reg_sex <- individuos_trans %>%
  group_by(REGION, CH04) %>% 
  summarise(PEA = sum(PONDERA[ESTADO==1|ESTADO==2]), #Calculamos la PEA
            desocupados=sum(PONDERA[ESTADO==2]), #Calculamos los desocupados
            tasa_desocupados = desocupados/PEA*100) %>%#Calculamos la Tasa de Desocupación
  ungroup() %>% 
  organize_labels("individual") %>% 
  organize_labels("hogar")


tasa_des_reg_sex

#Gráfico de la tasa de desocupación por regiones del país
#Gráfico de la tasa de desocupación por regiones del país
ggplot(data = tasa_des_reg_sex, 
       aes(x = factor(REGION), 
           y = tasa_desocupados, 
           fill = factor(CH04), 
           group = factor(CH04)),
       alpha=0.2) +
  geom_col(position = "dodge2") +
  geom_label(aes(label = sprintf('%.2f%%',tasa_desocupados)), 
             position = position_dodge2(0.9) ) +
  scale_fill_manual(values = c("#FF66FF", "#006666")) +  
  labs(title = "Tasa de desocupación por región y sexo",
       caption = "EPH: cuarto trimestre año 2020", 
       x = NULL, y=NULL, fill = "Sexo") +
  theme_minimal() +
  theme(axis.text.x = element_text(size = 10, face = "bold"),
        plot.title = element_text(size = 14, face = "bold", hjust = 0.5), 
        plot.caption = element_text(size = 10, face = "bold.italic"),
        legend.text = element_text(size = 10, face = "bold"))



# ¡Al barro! - Act. II -------------------------------

# Para finalizar proponemos un cierre práctico que 
# aborde los temas que vimos en este encuentro. 
# Para esto les pedimos que: 
#  
#  1. Cargen la última EPH disponible en R
#  2. Calculen la Tasa de Desocupación nacional
#  3. Comparen el resultado nacional con las regiones
#  4. Elijan un aglomerado a elección y calcule la tasa. 
#  5. Por último,escriban un parrafo resumiendo los puntos que considera sobresalientes. 
