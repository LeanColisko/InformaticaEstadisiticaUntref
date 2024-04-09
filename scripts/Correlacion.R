# Creamos dos variables
x <- 5:16
y <- 16:5
plot(x = x, y = y)
cor(x = x, y = y, method = "pearson")
cor.test(x = x, y =  y, method = "pearson")
  


# Correlacion de pearson
r = sum( (x - mean(x)) *  (y - mean(y)) ) / ( (length(x) - 1 ) *  sd(x) * sd(y) )


#Ahora aleatorio
col_a_r <- sample(5:16, 12, replace=TRUE)
col_b_r <- sample(5:16, 12, replace=TRUE)
plot(x = col_a_r, y = col_b_r)
cor(x = col_a_r, y =  col_b_r)
cor.test(x = col_a_r, y =  col_b_r, method = "pearson")









# Datos
library(haven)
library(dplyr)
world <- read_sav("datos/World95_5.sav")

input_corr <- world %>% 
  dplyr::select(lifeexpm, babymort, literacy, gdp_cap, calories, fertilty) %>% 
  as.matrix()

library(Hmisc)
library(corrplot)
corr <- rcorr(input_corr, type=c("pearson"))
corr[[1]]
corrplot(corr[[1]], number.digits = 2)
?rcorr


input_corr_expectativa <- world %>% 
  select(lifeexpm, lifeexpf) %>% 
  as.matrix()
corr <- rcorr(input_corr_expectativa, type=c("pearson"))
corr
corrplot(corr[[1]], number.digits = 2, )

plot(x = world$lifeexpm, y = world$lifeexpf)
plot(world %>% select(lifeexpm, gdp_cap, calories))




library(ggplot2)
ggplot(world, aes(x = lifeexpm, y = lifeexpf, label=country)) +
  geom_point() +
  geom_smooth(method = lm, se = FALSE) 




x <- sample(5:16, 12, replace=TRUE)
y <- sample(5:16, 12, replace=TRUE)
plot(x = x, y = y)
sum( (x - mean(x)) *  (y - mean(y)) ) / ( (length(x) - 1 ) *  sd(x) * sd(y) )
cor(x, y)
