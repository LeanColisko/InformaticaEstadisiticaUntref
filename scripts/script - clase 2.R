# Topicos de la jornada anterior:
#   Interfaz de R
#   Definir un objeto
#   Operadores:
#       Comparación
#       Lógicos
#       Aritméticos
#   Tipo de datos: character, logico, numerico, NA tipo de dato especial
#   Funciones predefinidas
#   Ayudas
#   Librerías

provincia <- 1


####  TIPOS DE OBJETO ----------------------------

# Vectores
notas_alumnes <- c(9, 8, 7, 9, 10)

notas_alumnes

notas_alumnes2 <- c('A', TRUE, 7, 'C', 10)

is.vector(notas_alumnes)


# propiedades
class(notas_alumnes)

length(notas_alumnes)

# subseting
notas_alumnes[5]

notas_alumnes[c(1, 3, 5)]




# Matrices ----------------------------------------
# Creamos una matriz de 3x3 
# con numeros del 1 al 9
mi_matriz <- matrix( 1:9, 
                    nrow = 3, 
                    ncol = 3, 
                    byrow = F) 
mi_matriz
mi_matriz[ 3 , c(2, 3)]
mi_matriz[ 3 , 2:3]


# Le pregunto al R si el objeto que defini es una matriz
is.matrix(mi_matriz)



# clase
class(mi_matriz)

#largo
length(mi_matriz)

# subseting
mi_matriz[2, 1]

mi_matriz[1:2, 1:3]






# Dataframes ----------------------------------------
# Cada columna es un vector y puede ser tratada como tal:

# Tenemos las notas de 5 estudiantes
notas_alumnes <- c(9, 8, 6, 9, 5 )

# Ahora escribimos los nombre
# El orden de los nombres tiene que corresponder a sus notas
nombre_alumnes <- c('Maria', 'Juana', 'Pedro',
                    'Mariana', 'Inti')

#Ahora definimos una nota de concepto
concepto_alumnes <- c("Bueno", 'Bueno', 'Muy bueno', 'Regular', 'Bueno')


#Hagamos una tabla con toda la información
curso <- data.frame(nombres_estudiantes = nombre_alumnes,
                    notas = notas_alumnes,
                    concepto = concepto_alumnes)

curso


# Usar el signo $ para acceder a las columnas de una tabla
curso$concepto


is.vector(curso$notas)


curso$notas > 7

curso$notas_columna_nueva <- curso$notas + 10

curso


# puedo modificar 
curso$notas_columna_nueva <- curso$notas_columna_nueva - 100

curso


# O agregar nuevas
curso$notas_mas <- curso$notas + 1

curso


# clase
class(curso)

#nombre de columnas
nombre_de_columnas <- colnames(curso)

#n columnas
ncol(curso)

# nombre de las filas
row.names(curso)

# n de filas
nrow(curso)


# subseting
curso[3:5, 1:3]



# Objetos con dos dimensiones 
# Me quedo con el primer registro de la primer columna
curso[    curso$notas < 8   & curso$concepto == "Muy bueno",   ]





curso$notas < 8
curso$notas

# Segunda fila todos los registros
curso[c(2, 3, 4), 2:3]






# Pregunta
# ¿Cómo podremos hacer para quedarnos 
# con todas los datos de los alumnes que tengan concepto Bueno?








# Listas ----------------------------------------
# Voy a poner todo lo que tengo en una lista
mi_lista <- list(tabla = curso,
                 tabla2 = curso,
                  matriz = mi_matriz, 
                  mi_nombre = 'Leandro',
                  mi_edad = 25,
                  mi_vector = 1:10, 
                 otra_lista = list(variable= "Hola"))

mi_lista
# Pueden ser muy útiles para guardar múltiples tablas. 
# También es bueno conocerlas

# propiedades
length(mi_lista)











### Leyendo archivos ----------------------------------------

# Ubicando el directorio de trabajo
getwd()

# Ustedes tienen que cambiarlo por la ubicación en su computadora
#setwd("../../../../Documents/")

getwd()

#setwd("/Users/leandrocolisko/Documents/Leandro/curso inap")





getwd()





# Leyendo archivos de diferente formatos
encuesta_cc <- read.csv(file = "datos/encc_2017.csv")
#encuesta_cc2 <- read.csv(file = "/Users/leandrocolisko/Documents/Leandro/UNTREF/informatica-estadistica-2023/datos/encc_2017.csv")


#install.packages("haven")

library(haven)

df_spss <- read_sav(file = "datos/LOWBWT.sav")
df_stata <- read_dta("datos/LOWBWT.dta")
df_sas <- read_sas("datos/LOWBWT.sas7bdat")


# Leer archivos de excel
# install.packages("readxl")
library(readxl)
archivo_excel <- read_excel("datos/CuadroDeuda.xlsx")

archivo_excel$Porcentaje_Deuda_Externa <- archivo_excel$Deuda_Externa / archivo_excel$Total_Deuda


# Escribir datos
write.csv(x = archivo_excel, file = "ArchivosOutput.csv")
write.csv(x = df_spss, file = "LOWBWT.csv")







