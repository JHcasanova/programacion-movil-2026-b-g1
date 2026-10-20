# CP6 · Formulario de confirmación del pedido

El formulario principal confirma un pedido para recoger en tienda. Recibe los
productos configurados en el carrito, el nombre de quien recoge y una nota
opcional.

## Reglas de validación

| Campo o dato | Regla | Razón del dominio |
| --- | --- | --- |
| Carrito | Debe contener al menos un helado | No existe un pedido sin productos. |
| Nombre para recoger | Obligatorio, entre 2 y 80 caracteres | La tienda necesita identificar a la persona y evitar nombres vacíos. |
| Nombre para recoger | Se eliminan espacios al inicio y al final | Impide aceptar entradas compuestas solo por espacios. |
| Nota para la tienda | Opcional, máximo 300 caracteres | Permite una instrucción breve sin enviar contenido excesivo. |
| Total | Se calcula desde productos, tamaños, toppings y cantidades | El cliente no puede alterar el valor que valida el servidor. |
| Cantidad | Entre 1 y 20 unidades por configuración | Evita cantidades negativas o pedidos accidentales excesivos. |

## Retroalimentación

- El formulario valida el nombre durante la escritura.
- El botón permanece deshabilitado mientras los datos sean inválidos o se esté
  enviando el pedido.
- Durante el envío se muestra un indicador de progreso y se bloquea la salida.
- Un error del servidor aparece en una región activa y el carrito se conserva.
- Al completar el pedido se muestra “Pedido confirmado correctamente” y se abre
  Mis pedidos.
- Cancelar abre un diálogo de confirmación; los productos permanecen en el
  carrito aunque se descarten el nombre y la nota.

## Evidencia pendiente

Antes de cerrar CP6 se deben guardar en `docs/img/`:

- `after-formulario-invalido.png`
- `after-formulario-enviando.png`
- `after-formulario-exito.png`
- `after-formulario-error.png`
- `after-formulario-cancelar.png`
