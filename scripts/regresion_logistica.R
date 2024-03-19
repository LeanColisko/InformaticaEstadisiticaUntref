library(eph)
library(dplyr)
library(haven)
library(ggplot2)
library(caret)

# Odds = p / 1- p          Probabilidad de que ocurra sobre que no ocurra
df_eph <- get_microdata(year = 2020, 
                        trimester = 4, 
                        vars = c("PEA", "CH04", "CH06", "PONDERA", "ESTADO"),  
                        type ="individual")

df_eph <- read_sav("datos/individual_t212_4_1.sav")

colnames(df_eph) <- toupper(colnames(df_eph))

df <- df_eph %>%
  mutate(PEA = ifelse(ESTADO %in% c(1, 2), 1, 0),
         flag_sin_instr = ifelse(NIVEL_ED %in% c(7), 1, 0),
         flag_primario = ifelse(NIVEL_ED %in% c(1, 2), 1, 0),
         flag_secundario = ifelse(NIVEL_ED %in% c(3, 4), 1, 0),
          ) %>%
  filter(CH06 > 14) %>%
  select(PEA, CH04, CH06, PONDERA, P47T, flag_sin_instr, flag_primario, flag_secundario)


df %>%
  group_by(PEA) %>%
  summarise(CANT = sum(PONDERA))

# Regresión Logística
modelo.logistico <- glm(PEA ~ CH04 + CH06 + P47T, 
                        family=binomial, 
                        data = df)
options(scipen = 99)
summary(modelo.logistico)

modelo.logistico$coefficients

c = modelo.logistico$coefficients[1]
b1 = modelo.logistico$coefficients[2]
b2 = modelo.logistico$coefficients[3]
b3 = modelo.logistico$coefficients[4]
x1 = 1
x2 = 32
x3 = 1800

# Funcion logistica 
# p=1/1 + e**-z
# z=c+b1*x1+bp*xp
e = exp(1)
z = unname((c + b1*x1 + b2*x2 + b3*x3))
p = (e**z) /( 1 + e** z)
p = 1 /( 1 + e**-z)

# Chance sobre 33
chance_32 = p /(1-p)
chance_33 = p /(1-p)

# Cuanto cambia la chance a medida que incrementas una unidad
# RAZÓN DE MOMIOS
chance_33/chance_32 
exp(b2)
exp(0)
?exp

exp(modelo.logistico$coefficients)

# Coeficiente Wald en regresión loógistica
# Es el valor z elevado al cuadrado.
?glm.fit
?predict.glm
df$probabilidad <- predict.glm(modelo.logistico, type = "response")
df$probabilidad_2 <- modelo.logistico$fitted.values

df$LABEL <- ifelse(df$probabilidad > 0.5, 1, 0)


tabla <- table(df$PEA, df$LABEL)


#create confusion matrix
confusionMatrix(tabla)
?confusionMatrix




# Modelo con NIVEL_ED
modelo.logistico2 <- glm(PEA ~ CH04 + CH06 + P47T + flag_sin_instr + flag_primario +
                           flag_secundario, 
                        family=binomial, 
                        data = df)


summary(modelo.logistico2)



df$probabilidad <- predict.glm(modelo.logistico2, type = "response")
df$LABEL <- ifelse(df$probabilidad > 0.5, 1, 0)

tabla <- table(df$PEA, df$LABEL)

#create confusion matrix
confusionMatrix(tabla)



# Piramide poblacional
datos <- df_eph %>% 
  mutate(PEA = ifelse(ESTADO %in% c(1, 2), 1, 0)) %>%
  filter(CH06 > 14) %>%
  group_by(CH06, CH04) %>% 
  summarise(poblacion =  sum(PONDERA[PEA==1])/sum(PONDERA)) %>% 
  ungroup() %>% 
  organize_labels("individual") %>% 
  mutate(gender = factor(CH04),
         edad = CH06,
         poblacion= ifelse(gender == "Mujer", -poblacion, poblacion))



#crear pirámide de población
ggplot(datos, aes(x = edad, fill = gender,
                  y = poblacion)) + 
  geom_bar (stat = "identity") +
  scale_y_continuous(limits = c(-1,1), 
                     breaks = c(-1, -0.5, 0, 0.5, 1),
                     labels = c("100%", "50%", "0", "50%", "100%")) +
  coord_flip () +
  labs(title = "Piramide poblacional en porcetaje", y="", x="Edad")



