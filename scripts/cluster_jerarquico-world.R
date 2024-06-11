# Activamos las librerias
library(haven)
library(dplyr)


# leemos los datos
world <- read_sav("datos/World95_5.sav")

# Visualizamos los datos
head(world)

# Filtramos los datos y reducimos las variables
datos_clean <- world %>%
  filter(region == 6) %>% 
  select(country, lifeexpf, gdp_cap, literacy)


# Nos quedamos con el vector de paises
paises <- datos_clean$country















# Re-escalamos los datos numéricos
datos <- scale(datos_clean %>% select(-country)) 
?scale




# Que pasa si dejamos la categoria de paises
datos <- scale(datos_clean) 
?scale


# Damos el nombre a cada fila
row.names(datos) <- paises



# Calculamos la matriz de distancia de todos vs todos
x <- dist(datos)
?dist





# Construimos el modelo jerárquico con diferentes métodos
cluster.comp <- hclust(x, method = "complete")
cluster.single <- hclust(x, method = "single")
cluster.avg <- hclust(x, method = "average")
cluster.ward <- hclust(x, "ward.D")

?hclust



# Visualizamos los resultados
cluster.comp
cluster.single
cluster.avg
cluster.ward



# Graficamos un dendográma
plot(as.dendrogram(cluster.avg), main = "Dendograma: cluster average")




# Utilizamos cutree: 
# Para etiquetar cada observación según su pertenencia a un grupo
table(cutree(cluster.avg, 4))
?cutree

# Dendográma más cheto
library(ggdendro)
library(ggplot2)
ggdendrogram(cluster.avg, rotate=TRUE, size = 2) +
  labs(title = "Dendograma en R: Método Avg") +
  theme(plot.title = element_text(hjust = 0.5))



# Guardamos la etiquetas en cada 
datos_clean$grupos <- cutree(cluster.avg, 4)

# Medias de resumen de los grupos
datos_clean %>%
  group_by(grupos) %>%
  summarise(media_gdp = mean(gdp_cap),
            media_lit = mean(literacy),
            media_life = mean(lifeexpf),
            cantidad_paises = n())


# Gráfico 3d con las variables originales
library(plotly)
plot_ly(data = datos_clean,
        text = ~country,
        x = ~gdp_cap, 
        y = ~literacy, 
        z = ~lifeexpf, 
        type="scatter3d", 
        mode="markers", color=~factor(grupos)) %>%
  layout(title = 'Gráfico de puntos 3D',
         legend = list(title=list(text='<b>Grupos</b>'))) 
