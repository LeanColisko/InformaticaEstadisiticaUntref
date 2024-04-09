#### R y R studio ----------------------------------
# Source
# Console
# Environment, global environment, History
# Files, Plots, Packages, Help, Viewer
# Barra de herramienta, aspecto y ayudas

# Comentarios
# Todo lo que estas viendo en estas priemras lineas
# es un comentario en el script.


# colisko_leandro@live.com.ar
# 1131900516
# 2477675616





### Todo en R es un Objeto  -----------------------
# Todo es un objeto en R
# R es literal
provincia_1 <- "Córdoba"
provincia_1


# Creamos un nuevo objeto
provincia_2 <- "La Rioja"

provincia_2

# Ahora un objeto numérico
anio_fundacion_cordoba <- 1573

#Ctrl + Enter: ayuda de teclado para ejecutar una instruccion

# Uno más
anio_fundacion_la_rioja <- 1591


#no se puede nombrar con espacios.
anio_de_fundacion_de_la_rioja_1591 <- 1591

provincia_1







### Operadores ------------------------------------

### Comparación -----------------------------------
# Igualdad (==)
provincia_1 == provincia_2


# Diferencia (!=)
provincia_1 != provincia_2


# Mayor (>)
10 > 5

# Mayor o igual (>=)
5  >= 20

# Menor (<)
3 < 100

# Menor o igual (<=)
6 <= 6

anio_fundacion_cordoba < anio_fundacion_la_rioja



#### Operadores aritméticos -----------------------

# Suma
2 + 2

# Resta
2 - 2

# División
2 / 2

# Multiplicación
2 * 2

# Potencia
2 ^ 2
2 ** 2

# Módulo
5 %% 2

# Tambien podemos hacer sobre objetos que ya hemos definido
a <- 20
b <- 30

a + b
a * b
a ^ b

c <- a / b 



### Operadores lógicos --------------------------
# Negación
!( provincia_1 == provincia_2 )
!FALSE

# Ó lógico para chequear entre dos condiciones (|)
(provincia_1 == provincia_2) | anio_fundacion_cordoba != anio_fundacion_la_rioja 



# Y lógico para chequear entre dos condiciones (&)
(provincia_1 == provincia_1) & anio_fundacion_cordoba != anio_fundacion_la_rioja 



# Tabla de verdad con operadores lógicos

# Negación
!TRUE
!FALSE

# Ó
TRUE  | TRUE
TRUE  | FALSE
FALSE | TRUE
FALSE | FALSE

# Y
TRUE  & TRUE
TRUE  & FALSE
FALSE & TRUE
FALSE & FALSE













# Tipos de datos ------------------------------

# Class para evaluar el tipo de dato
# Character
class(provincia_1)

# Numeric
class(anio_fundacion_cordoba)

# Creamos un tipo de dato lógico
compara <- provincia_1 == provincia_2

class(compara)

# Formas de declarar valores lógicos
TRUE
T
FALSE
F


# Un tipo de dato especial NA
NA



# Numeric: integer y float y double
# Character: character y factor
# logical


# factor
encuesta <- factor(c("bueno", "regular", "malo", "bueno", "bueno"), 
                levels = c("malo", "regular", "bueno"))

encuesta_text <- c("bueno", "regular", "malo", "bueno", "bueno")
class(encuesta)
class(encuesta_text)

plot(encuesta)
plot(table(encuesta_text))














#### Funciones -------------------------------------
notas_alumnes <- c(8, 7, 6, 9, 10, NA)

notas_alumnes

# Evaluando las estadisticas descriptivas de nota_alumnes
# Promedio del curso
mean(x = notas_alumnes)

mean(notas_alumnes, na.rm = TRUE)

# Suma de las notas
sum(notas_alumnes, na.rm=T)

# Mediana
median(notas_alumnes, na.rm=TRUE)

# Desvio estandar
sd(notas_alumnes, na.rm=TRUE)

# Varianza
var(notas_alumnes, na.rm=TRUE)

# Percentil 90
quantile(notas_alumnes, na.rm = TRUE)
quantile(notas_alumnes, na.rm = TRUE, probs = c(0.05, 0.95))
quantile(notas_alumnes)




#### Ayudas --------------------------------------
# conocer los argumentos de una funcion
args(lm)

# Con signo de pregunta
?sum

# llamando a la funcion help
help('lm')

# Pedir un ejemplo
example('sum')


# Sino tambien podemos reccurrir a google
# https://stackoverflow.com/
# Siempre es un gran lugar







# Trabajar con el enviroment -------------------------------

# leer los objetos que tengo en el ambiente de trabajo
ls()

rm("b")

# eliminar los objetos
rm(list = ls())

#Asegurarme que los eliminé
ls()











# Ejecicio
iris <- iris

# Vectores
Sepal.Length <- iris$Sepal.Length
Sepal.Width <- iris$Sepal.Width
Petal.Length <- iris$Petal.Length
Petal.Width <- iris$Petal.Width

# Invesitigar de que se trata cada una de las variables del dataset iris
# Obtener todas las medidas de estadística descriptiva para cada una de las variables
# Comentar sobre los resultados obtenidos.








