# CP3 · Estados del catálogo

La lista trabajada es el catálogo de sabores. Sus datos salen de
`GET /api/products` en modo conectado y de `demoProducts` en demostración.

| Estado | Comportamiento | Cómo forzarlo |
| --- | --- | --- |
| Cargando | Esqueleto con encabezado, búsqueda y cuatro tarjetas | `flutter run --dart-define=CATALOG_DELAY_MS=5000` |
| Con datos | Tarjetas de Fresa de temporada, Chocolate intenso y demás sabores | `flutter run` |
| Vacío | Mensaje “Aún no hay sabores disponibles” y acción para recargar | `flutter run --dart-define=CATALOG_MODE=empty` |
| Error | Mensaje de conexión y botón Reintentar | `flutter run --dart-define=CATALOG_MODE=error` |

El `RefreshIndicator` permite actualizar el catálogo al deslizar hacia abajo en
el estado con datos. El reintento reutiliza `loadProducts`, limpia el error,
muestra de nuevo el esqueleto y vuelve a consultar la fuente configurada.

## Prueba automatizada

`test/widget_test.dart` inyecta un cargador que falla en la primera llamada y
devuelve los sabores en la segunda. La prueba comprueba el mensaje de error,
pulsa Reintentar, verifica dos solicitudes y confirma que aparece Fresa de
temporada junto al control de recarga.

Comando de verificación:

```text
flutter test
```

## Capturas pendientes

Antes de cerrar CP3 se deben guardar en `docs/img/`:

- `after-catalogo-cargando.png`
- `after-catalogo-datos.png`
- `after-catalogo-vacio.png`
- `after-catalogo-error.png`
