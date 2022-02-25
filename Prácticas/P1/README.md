# Práctica 1

## Integrantes 

- Diego Marcial Fenrández Del Valle 314198039 
-  
## Ejercicio 5

### Algoritmo

El algoritmo busca construir nivel por nivel todos los árboles posibles. Para eso generamos la función one-depth-tree que genera todos los árboles posibles de profundidad 1, posteriormente con la función combinations hacemos la llamada al método recursivo y limpiamos la salida y quitamos árboles duplicados, por último con la función all-combinations genera todos los árboles de la siguiente manera: 
Primero nos fijamos si la profundidad que nos falta por calcular  es 0 regresamos null pues estp quiere decir que bajo esta ejecución el árbol no puede crecer más sobre este nodo puesto que infrinjiría la regla de profundidad establecida

Una vez verificado lo anterior nos fijamos en el nodo que recibimos. Si recibimos un nodo no final, aplicamos recursión sobre los nodos hijos según corresponda

Si encontramos una hoja podemos agregar varios árboles a la lista:

- Para empezar agregamos a la lista el árbol actual
- Cada árbol sustituyendo el nodo actual por alguno de los 3 escenarios de one-depth tree
- La recursión de la función combinations sobre los árboles resultantes de intercambiar el nodo actual por uno de los casos de one-depth-tree
