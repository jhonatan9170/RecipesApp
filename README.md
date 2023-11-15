
# RecipesApp

RecipesApp es una aplicacion sencilla con 3 pantallas(lista de recetas, detalles de recetas, mapa de origen) , es un reto tecnico para la posicion de iOS engineer , se utilizó las mejores practicas que conozco.


## MVVM + Builder+Router
Se implementa la solucion con esta arquitectura para hacer la app simple pero con gran desacoplamiento
Cada Modulo posee un :

- **View:** Solo se encarga de la vista el diseño y de comportamientos de la app, solo se comunica con el modelo 

- **ViewModel:** se ejecuta toda la logica de negocios, comunica con los servicios, tiene referencia para actualizar la vista y con el Router

- **Router:** Se encarga de la navegacion entre vistas 

- **Builder:** Se encarga de crear todos lo componentes, referenciarlos y de inicializar el modulo




## Librerias externas

 - [KingFisher](https://cocoapods.org/pods/Kingfisher) : nos facilitó la cargar de imagenes mediante URL



## Flujo 
### Recipes
![Recipes](https://raw.githubusercontent.com/jhonatan9170/RecipesApp/main/assets/RecipesImg.png)

El flujo inica con las lista de recetas (Recipes) que carga los datos desde un mock online.
Se puede filtrar mediante el nombre del plato , todos los platos no son peruanos  es solo una referencia.
Al hacer click en cualquiera de las celdas nos dirigirá al detalle


### RecipeDetail
![Parte superior](https://raw.githubusercontent.com/jhonatan9170/RecipesApp/main/assets/RecipesDetail1.png)


![Parte inferior](https://raw.githubusercontent.com/jhonatan9170/RecipesApp/main/assets/RecipeDetail2.png)


Nos muestra el detalle de cada plato , a diferencia del modulo anterior aqui si se consume un api real , a veces se caes y es lento. La localizacion es referencial , es un dato puesto manualmente del mock anterior
Al hacer click en Location nos lleva a la pantalla de location

### Location
![Location Image](https://raw.githubusercontent.com/jhonatan9170/RecipesApp/main/assets/Location.png)

Muestra la localizacion en el mapa hace uso de Geocoder para traer las coordenadas de cada ciudad.

## API

[ MockRecipesList](https://654dd11ccbc325355741ed1b.mockapi.io/v1)

[ BBCGoodFoodAPI](https://rapidapi.com/boxapi/api/bbc-good-food-api)
