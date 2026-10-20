# CP2 · Navegación y tokens de diseño

## Patrón elegido

La app conserva una barra de navegación inferior con tres destinos: **Helados**,
**Carrito** y **Mis pedidos**. Son secciones principales, están al mismo nivel y
se consultan varias veces mientras se arma un pedido. La pantalla Confirmar
pedido continúa en una pila porque depende del contenido del carrito y necesita
un regreso claro.

El patrón evita ocultar acciones frecuentes en un menú y mantiene visible el
conteo del carrito. La personalización de Fresa de temporada, Chocolate intenso
u otro sabor sigue como hoja inferior porque es una tarea breve y contextual.

## Tokens

Los tokens se encuentran en `app/frontend/lib/theme.dart` y se aplican desde un
único `ThemeData`.

| Grupo | Token | Valor | Uso |
| --- | --- | --- | --- |
| Color | `primary` | `#8A2942` | Acciones principales y selección |
| Color | `secondary` | `#5B3A00` | Acentos secundarios |
| Color | `success` | `#1B6B3A` | Confirmación de pedido |
| Color | `error` | `#B3261E` | Fallos de catálogo y formulario |
| Color | `background` | `#FFF8F5` | Fondo general |
| Tipografía | `textSm` | 14 sp | Texto auxiliar y etiquetas |
| Tipografía | `textMd` | 16 sp | Lectura principal |
| Tipografía | `textLg` | 22 sp | Títulos de sección |
| Tipografía | `textXl` | 30 sp | Encabezado principal |
| Espacio | `spaceXs` a `spaceXl` | 4, 8, 16, 24, 32 dp | Ritmo y separación |
| Interacción | `minTouchTarget` | 48 dp | Tamaño táctil mínimo |

## Contraste WCAG

Las relaciones se calcularon con luminancia relativa WCAG 2.1. Todas superan
4.5:1 para texto normal.

| Texto | Fondo | Relación |
| --- | --- | ---: |
| Blanco `#FFFFFF` | Primario `#8A2942` | 8.48:1 |
| Blanco `#FFFFFF` | Secundario `#5B3A00` | 10.24:1 |
| Blanco `#FFFFFF` | Éxito `#1B6B3A` | 6.54:1 |
| Blanco `#FFFFFF` | Error `#B3261E` | 6.54:1 |
| Texto `#231F20` | Fondo `#FFF8F5` | 15.52:1 |
| Texto secundario `#5F5A5C` | Fondo `#FFF8F5` | 6.44:1 |
