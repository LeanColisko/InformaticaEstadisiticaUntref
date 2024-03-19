library(haven)

world <- read_sav("tps_pasados/World95_5.sav")
lifeexpf.lm <- lm(lifeexpf ~ lifeexpm, data = world, na.action = na.exclude)

summary(lifeexpf.lm)
anova(lifeexpf.lm)

predicion <- predict(lifeexpf.lm)
residuos <- residuals(lifeexpf.lm)
residuos_standarizados <- rstandard(lifeexpf.lm)
y <- world$lifeexpm



cor(predicion, lifeexpf.lm$model$lifeexpf)

# R2
# R
# Suma Cuadrados con ANOVA. Analisis de la varianza
  # Regresion: aporte de la variable
  # Residuo: Suma de cuadrados de los residuos.
  # Estadístico F del ANOVA.

plot(world$lifeexpm, world$lifeexpf)
abline(lifeexpf.lm)

predict(lifeexpf.lm, newdata = data.frame(lifeexpm = c(72)))

variables <- data.frame(country = world$country,
                        lifeexpf = world$lifeexpf,
                        lifeexpm = world$lifeexpm,
                        predicion, residuos, residuos_standarizados)
options(scipen = 99)




# regresion multiple
modelo.lm <- lm(lifeexpf ~ gdp_cap + lifeexpm +  literacy, data = world, na.action = na.exclude, )

summary(modelo.lm)
anova(modelo.lm)

predicion <- predict(modelo.lm)
residuos <- residuals(modelo.lm)
residuos_standarizados <- rstandard(modelo.lm)
y <- world$lifeexpm


library(QuantPsyc)
lm.beta(modelo.lm) 
?lm.beta



step(modelo.lm, direction = "both")
slm1 <- step(modelo.lm)
summary(slm1)

slm1$anova
# Falta conocer como sacar los Beta Estandarizados



####### Adicional ------------------------------------
# Obtener el ERROR ESTANDAR DE LA REGRESION (EER)
# En R se llama RESIDUAL STANDAR ERROR
n <-  nrow(lifeexpf.lm$model)     # Observaciones
k <- ncol(lifeexpf.lm$model) - 1  # Regresores
o2 <- sum(lifeexpf.lm$residuals ** 2) / (n - k - 1)
o_EER <- sqrt(o2)

#Calcular a mano la R2
# R2 = SEC/STC = 1 - SRC/STC
# SUMA TOTAL DE CUADRADOS (STC)
y_mean = mean(lifeexpf.lm$model$lifeexpf)
y = lifeexpf.lm$model$lifeexpf
stc = sum((y - y_mean) ** 2 )

# SUMA EXPLICADA DE CUADRADOS (SEC)
y_ajust = lifeexpf.lm[["fitted.values"]] # es lo mismo que predicion
sec = sum((y_ajust - y_mean)** 2 )

# SUMA RESIDUALES DE CUADRADOS (SRC)
src = sum( lifeexpf.lm$residuals ** 2 )

####### R2 ------------------------------
# R2
r2 = sec / stc
# or
r2_1 = 1 - src / stc





##### Estadistico F ------------------------------
# Modelo restringido
mod_restringido <- lm(lifeexpm ~ 1, data = world)

# SUMA RESIDUALES DE CUADRADOS (SRC): Modelo restringido
src_r = sum( mod_restringido$residuals ** 2 )

# Q: son los grados de libertad del modelo restringido y el completo
q = (n - 1) - gl

# Estadístico F: siempre es positivo
f = ((src_r - src)/ q ) / (src / gl)




