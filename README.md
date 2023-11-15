
# RecipesApp

RecipesApp es una aplicación sencilla con 3 pantallas(lista de recetas, detalle de recetas, mapa de origen) , es un reto técnico para la posición de iOS Engineer , se utilizó las mejores prácticas que conozco.

## MVVM + Builder + Router
Se implementa la solución con esta arquitectura para hacer la app simple pero con gran desacoplamiento
Cada Módulo posee un :
- **View:** se encarga de la maquetación de la pantalla, mostrar controles y recibir instrucciones del usuario para mandarlos al View Model
- **ViewModel:** es un intermediario entre el View y el Model, se encarga de recibir instrucciones del View y aactualizar al mismo, asimismo es el responsable de mandar instrucciones al router para iniciar la navegación.
- **Model:** contiene toda la logica de negocio.
- **Router:** se encarga de la navegación entre modulos MVVM.

- **Builder:** se encarga de crear todos lo componentes, referenciarlos y de inicializar el modulo.

### Maquetacion
La maquetación se hizo usando el framework UIKit mediante uso de xibs.


## Librerias externas

 - [KingFisher](https://cocoapods.org/pods/Kingfisher) : nos facilitó la carga de imagenes mediante URL.



## Flujo 
### Recipes
![Recipes](https://raw.githubusercontent.com/jhonatan9170/RecipesApp/main/assets/RecipesImg.png)

El flujo inicia con las lista de recetas (Recipes) que carga los datos desde un mock online.
Se puede filtrar mediante el nombre del plato , todos los platos no son peruanos  es solo una referencia.
Al hacer click en cualquiera de las celdas nos dirigirá al detalle.


### RecipeDetail
![Parte superior](https://raw.githubusercontent.com/jhonatan9170/RecipesApp/main/assets/RecipesDetail1.png)


![Parte inferior](https://raw.githubusercontent.com/jhonatan9170/RecipesApp/main/assets/RecipeDetail2.png)


Nos muestra el detalle de cada plato, a diferencia del módulo anterior aquí si se consume una API real , a veces se cae y es lento. La localizacion es referencial , es un dato puesto manualmente en el mock anterior.
Al hacer click en el botton "Location" nos lleva a la pantalla de "Location".

### Location
![Location Image](https://raw.githubusercontent.com/jhonatan9170/RecipesApp/main/assets/Location.png)

Muestra la localización en el mapa ,hace uso de la libreria de apple CLCoreLocation para traer las coordenadas de cada ciudad.

## API

[ MockRecipesList](https://654dd11ccbc325355741ed1b.mockapi.io/v1)

[ BBCGoodFoodAPI](https://rapidapi.com/boxapi/api/bbc-good-food-api)
