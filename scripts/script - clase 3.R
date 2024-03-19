
# Tidyverse ---------------------------------------------------
library(dplyr)
library(readr)
 



# Encuesta de Consumos Culturales -----------------------------
encuesta_cc <- read_csv(file = "datos/encc_2017.csv")




# Select -----------------------------------------------------
encuesta_clean <- encuesta_cc %>% 
  select(id, pondera_dem, fecha, region, sexo, 
         edad, p1, p1otros,
         p2, p3, p4, p5, p6horas, p6minutos, p7_1) 



# Atajo de teclado para generar el pipe
# Ctrl + Shift + M





### Filter -----------------------------------------------------
# Primero observamos los campos únicos que tiene la variable region
unique(encuesta_clean$region)
table(encuesta_clean$region)
prop.table(table(encuesta_clean$region))

# nos vamos a quedar con la región NOA y NEA
encuesta_clean <- encuesta_clean  %>%
  filter(region == "NOA" | region == "NEA")



# inspeccionamos que sean esas dos únicas regiones
unique(encuesta_clean$region)
table(encuesta_clean$region)

# insepeccionamos el valor de sexo
unique(encuesta_clean$sexo)

#Nos quedamos con los casos de mujeres de NOA
mujeres_noa <- encuesta_clean %>% 
  filter(region == "NOA" & sexo == "Mujer" & edad %in% c(18:29)) 





# Group by and summarise --------------------------------------
encuesta_clean %>% 
  group_by(region) %>% 
  summarise(cantidad_entrevistados = n(),
            cantidad_personas = sum(pondera_dem),
            minimo_edad = min(edad),
            maximo_edad = max(edad),
            promedio_edad = mean(edad))


tabla_resumen <- encuesta_clean %>% 
  group_by(region,sexo) %>%
  summarise(Personas = sum(pondera_dem),
            Promedio_edad = mean(edad),
            Mediana_edad = median(edad))

tabla_resumen



library(openxlsx)
write.xlsx(tabla_resumen, "mi_resultado.xlsx")


### Arrange -----------------------------------------------------
tabla_resumen %>%
  arrange(Personas) 


tabla_resumen %>% 
  arrange(desc(Promedio_edad))


### Mutate --------------------------------------
encuesta_clean <- encuesta_clean %>%
  mutate(es_menor = ifelse(edad < 18, 'es menor de edad', 'es mayor de edad'),
         fecha_de_hoy = '2022-01-01',
         edad = 1,
         edad_mas_100 = edad + 100) 



encuesta_clean <- encuesta_clean %>% 
  mutate(edad_categorica = case_when( 
           edad  < 18              ~ 'menor de edad',
           edad  > 17 & edad <= 30 ~ '18 a 30',
           edad  > 30 & edad <= 45 ~ '31 a 45',
           edad  > 45 & edad <= 60 ~ '46 a 60',
           edad  > 60 & edad <= 75 ~ '61 a 75',
           edad  > 75 ~ '76 o más'
           )
         ) 





# pipe todo junto %>%  ------------------------------------------
encuesta_cc %>% # 1 - utilizo un df como input
  select(pondera_dem, region, edad, p2) %>% # 2 - seleccionar variables relevantes
  filter(region == "NOA" | region == "NEA") %>% # 3 - filtro nuestros datos
  mutate(edad_categorica = case_when( 
    edad  < 18              ~ '1 . menor de edad',
    edad  > 17 & edad <= 30 ~ '2 . 18 a 30',
    edad  > 30 & edad <= 45 ~ '3 . 31 a 45',
    edad  > 45 & edad <= 60 ~ '4 . 46 a 60',
    edad  > 60 & edad <= 75 ~ '5 . 61 a 75',
    edad  > 75 ~ '6 . 76 o más')
  ) %>% # 4 - crear una variable
  group_by(edad_categorica) %>% # 5 - agrupar nuestros datos
  summarise(Personas = sum(pondera_dem), # 6 - creo los indicadores
            Escucho_radio_en_ultimo_anio = sum(pondera_dem[p2 == 'SI']),
            Porcentaje_que_escucha_radio = (Escucho_radio_en_ultimo_anio / Personas) * 100)






# Al barro Act 1 --------------------------------------------

# Antes de continuar proponemos hacer un pequeño ejercicio, con la encuesta de consumos culturales que estamos analizando.
# Tomando la tabla encuesta_clean, saquemos:
#   * ¿Qué tipo de radio es escuchada por más personas, AM o FM? 
#   * ¿Es igual en las regiones NOA y NEA?
#   
#   Una pista, cada observación representa a un 
#   conjunto mayor de la población, por lo tanto, para contar personas, 
#   tenemos que sumar la variable de ponderación.



# Actividad para el hogar ---------------------------------------

# Cómo comentamos al principio la encuesta recoge información sobre diferentes consumos culturales. Les dejamos como ejercicio para la semana, que seleccionen alguno aspecto de su interés y con lo incorporado hasta el momento:
#   Seleccionen las variables relevantes para ustedes.
# Realicen algún filtro para segmentar a la población.
# Realicen la agrupación y el resumen de las variables de interés para describir el problema.














# Activamos la libreria
library(dplyr)
# Ejemplo de joins -------------------------------------
# Creamos una tabla: notas de sociales
notas_soc <- data.frame(id_alumnes = c(LETTERS[1:5]),
                        notas_soc = c(10, 8, 9, 5, 9))
notas_soc

# Creamos la tabla: notas de matematica
notas_mat <- data.frame(id_alumnes = c(LETTERS[1:3]),
                        notas_mat = c(8, 9, 7))
notas_mat

# Left join
notas_soc %>%  
  left_join(notas_mat, by = c("id_alumnes"="id_alumnes"))

notas_mat %>%  
  left_join(notas_soc, by = c("id_alumnes"="id_alumnes"))


# Inner join
notas_soc %>% 
  inner_join(notas_mat, by = c("id_alumnes"="id_alumnes"))






