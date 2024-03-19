library(haven)
library(dplyr)
library(tidyr)


# Con datos de prueba
test <- data.frame(nombre=c("juan", "pedro", "ana", "jose"),
                   r1 = c(1, 2, 5, 2),
                   r2 = c(2, 1, 3, 5),
                   r3 = c(5, 4, 1, 9))
test <- test %>% 
  pivot_longer(cols = starts_with("r"), values_to = "respuesta", names_to = "orden", names_prefix = "r")

test %>% 
  count(respuesta, sort = T)

n_encuestados <- length(unique(test$nombre))
test %>% 
  group_by(respuesta) %>% 
  summarise(cant = n()) %>% 
  mutate(porcentaje_total = cant / sum(cant),
         porcentaje_por_encuestados = cant / n_encuestados)

  
  
# Análisis con multiples respuestas de una encuesta
df <- read_sav(file = "datos/buenosaires1997_1.sav") %>% 
  mutate(across(where(is.labelled), ~as_factor(.))) # Uso las etiquetas con 

# Cantidad de
n_encuestados <- nrow(df)

df_n <- df %>% 
  select(starts_with("preg1."), preg30) %>% 
  pivot_longer(cols = starts_with("preg1."), values_to = "respuesta", names_to = "orden", names_prefix = "preg1.") %>% 
  na.omit() %>% 
  mutate(Pondera=ifelse(orden == 1, 2, 1) ) # Creo el ponderador



# Resultados Nacionales
df_n_general <- df_n %>% 
  group_by(respuesta) %>% 
  summarise(Cantidad = n()) %>% 
  mutate(porcentaje_total = (Cantidad / sum(Cantidad)) * 100,
         porcentaje_por_encuestados = (Cantidad / n_encuestados)*100)




# Resultados Nacionales Ponderado
df_n_ponderado <- df_n %>% 
  group_by(respuesta) %>% 
  summarise(Cantidad = sum(Pondera)) %>% 
  mutate(porcentaje_total = (Cantidad / sum(Cantidad)) * 100,
         porcentaje_por_encuestados = (Cantidad / n_encuestados)*100)




# Tabulación Ingresos y Pregunta 1
ProbNacionales_X_ingresos <- df_n %>% 
  group_by(respuesta, preg30) %>% 
  summarise(Cantidad = n()) %>% 
  group_by(preg30) %>% 
  mutate(Respuestas_por_Grupo = sum(Cantidad),
         Porcentaje_Respuesta_por_Grupo = Cantidad/Respuestas_por_Grupo*100) %>% 
  ungroup()

# Imprimo los N
ProbNacionales_X_ingresos %>% 
  pivot_wider(id_cols = respuesta, 
              names_from = preg30, 
              values_from = Cantidad, 
              values_fill = 0.0)

# Imprimo los Porcentajes
ProbNacionales_X_ingresos %>% 
  pivot_wider(id_cols = respuesta, 
              names_from = preg30, 
              values_from = Porcentaje_Respuesta_por_Grupo, 
              values_fill = 0.0)




