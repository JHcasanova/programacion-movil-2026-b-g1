# CP4 · Accesibilidad y diseño responsivo

## Correcciones aplicadas

- El buscador conserva una etiqueta visible “Buscar sabores” y usa “Ejemplo:
  fresa” solo como ayuda.
- Los avisos de almacenamiento y los errores de confirmación son regiones
  activas para que el lector de pantalla anuncie sus cambios.
- Cada tarjeta anuncia nombre, categoría y precio inicial, por ejemplo “Fresa
  de temporada, Clásicos, desde $ 2.500 COP”.
- El botón de favoritos expone su estado seleccionado y mantiene un tooltip que
  explica si añade o quita el sabor.
- La cantidad de cada producto del carrito tiene una etiqueta semántica.
- Los botones con icono y los botones principales tienen un área mínima de 48
  dp, superior al requisito de 44.
- La cuadrícula muestra una columna por debajo de 420 dp, dos desde 420 dp y
  tres desde 700 dp. Así los nombres y precios no se comprimen a 360 px.
- El formulario de confirmación limita su ancho a 640 dp para conservar una
  línea de lectura cómoda en tabletas.
- Los textos usan el escalado nativo de Flutter; no se limita `textScaler`.
- Los estados no dependen solo del color: incluyen icono, texto y acción.

## Comprobación responsiva

| Ancho | Resultado esperado | Evidencia |
| ---: | --- | --- |
| 360 px | Catálogo de una columna, navegación inferior y formulario sin desborde | `img/after-catalogo-360.png` pendiente |
| 768 px | Catálogo de tres columnas y formulario centrado a 640 px | `img/after-catalogo-768.png` pendiente |

## Lighthouse · Accesibilidad

| Medición | Puntaje |
| --- | ---: |
| Antes de CP4 | Pendiente de ejecutar en la línea base |
| Después de CP4 | Pendiente de ejecutar en la versión actual |

Para completar la evidencia se debe ejecutar la app como Flutter web, abrir
Lighthouse en modo móvil y conservar las dos capturas y los dos puntajes reales.
No se registran valores estimados.
