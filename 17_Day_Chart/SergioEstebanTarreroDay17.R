setwd("C:/Users/Sergio/Desktop/30DayChartChallenge/17_Day_Chart")
getwd()

#install.packages("igraph")
library(igraph)

# Definir los nodos
blood_types <- c("A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-")

# Definir las aristas
edges <- matrix(c(
  "A+", "A+", "A+", "AB+",
  "A-", "A+", "A-", "A-", "A-", "AB+", "A-", "AB-",
  "B+", "B+", "B+", "AB+",
  "B-", "B+", "B-", "B-", "B-", "AB+", "B-", "AB-",
  "AB+", "AB+",
  "AB-", "AB+", "AB-", "AB-",
  "O+", "A+", "O+", "B+", "O+", "AB+", "O+", "O+",
  "O-", "A+", "O-", "A-", "O-", "B+", "O-", "B-", "O-", "AB+", "O-", "AB-", "O-", "O+", "O-", "O-"
), ncol = 2, byrow = TRUE)

# Crear el grafo
g <- graph_from_edgelist(edges, directed = TRUE)

# Calcular el grado de entrada para cada nodo
in_degree <- degree(g, mode = "in")

# Escalar los grados para usar como tamaño de nodo en la visualización
node_size <- in_degree * 5 + 10  # Ajustar el factor de escala según sea necesario

# Visualizar el grafo
plot(g, layout = layout_in_circle(g), vertex.size = node_size, vertex.color = "skyblue",
     edge.arrow.size = 0.5, vertex.label.color = "darkred", vertex.label.cex = 1.2,
     main = "Compatibilidad de Donación de Sangre")
