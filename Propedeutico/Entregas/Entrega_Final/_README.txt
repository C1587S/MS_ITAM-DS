El proyecto final tiene como objetivos la exploración de múltiples paquetes de R con el fin de realizar una aplicación sencilla
de los temas revisados en el curso. 

El tema elegido es:
Análisis descriptivo y estimación de modelos lineales con datos de Gapminder por medio de la implementación de una interfaz de usuario

Los paquetes utilizados fueron:
- shiny
- ggvis
- devtools
- tidyverse (específicamente los paquetes tidyr, dplyr, readr y ggplot2)

El objetivo es desarrollar unainterfaz de usuario que permite extraer datos transversales de la base de datos de "gapminder",
específicamente, luego de seleccionar un año y una región geográfica, el operador de la aplicación puede obtener los siguientes
productos:
- Tabla de estaísticas descriptivas (min, max, promedio, desv. estadar, iqr, q1, q3)
- Box plots de las dos variables seleccionadas
- Gráfica de los datos
- Tabla de resultados y visualización de la estimación de un modelo de regresión lineal
- Análisis de residuos

Dado el amplio set de variables que ofrece gapminder, y esta interfaz le permite al interesado realizar un análisis simple en un 
tiempo razonable para hacer una evaluación preliminar de conjuntos de datos de interés. 

Para el desarrollo de esta interfaz gráfica se recurrió a documentación disponible de forma pública en la web, y particularmente 
para el desarrollo de la gráfica de datos se tomó como base el repositorio disponible en https://github.com/cameres/gapminder-shiny. En la fase beta de este proyecto (antes de importar los datos directamente del repositorio de gapminder), se utilizan los archivos provistos por el github citado anteriormente  (en formato csv) para realizar un test de las funciones. 
Para el desarrollo del análisis de residuos, se tomó como base la documentación provista en: http://www.learnbymarketing.com/tutorials/linear-regression-in-r/
