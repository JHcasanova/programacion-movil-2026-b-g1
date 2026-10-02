Abre esa dirección en el navegador.

## Prueba de la aplicación

1.  Aparecen tres productos iniciales. 
2.  Escribe el nombre de un nuevo helado. 
3.  Escribe el sabor. 
4.  Escribe la descripción. 
5.  Escribe el precio. 
6.  Presiona "Crear producto". 
7.  El producto aparecerá en la lista. 
8.  Presiona "Ver detalle". 
9.  Se abrirá la pantalla de detalle. 
10.  Presiona "Volver" para regresar. 

## Manejo de errores

La aplicación muestra un mensaje cuando:

-  La API está apagada. 
-  Falta información del formulario. 
-  El precio no es válido. 
-  El producto solicitado no existe. 
-  Ocurre un error al realizar una petición. 

## Arquitectura

## Architecture

The application follows a simple client-server architecture using Ionic React and an Express REST API.

The Express API exposes the GET /api/productos endpoint to retrieve the list of products in JSON format.

The Ionic React application consumes this endpoint using the fetch function and displays the products on the main screen.

The application uses the POST /api/productos endpoint to send a new product from the form to the backend.

The API validates the received data and returns the created product as a JSON response.

The application also uses GET /api/productos/:id to retrieve the information of a specific product and display it on the detail screen.

This architecture separates the user interface from the backend logic and allows both parts to communicate through HTTP requests.

## Entrega en GitHub

Desde la raíz del repositorio:
