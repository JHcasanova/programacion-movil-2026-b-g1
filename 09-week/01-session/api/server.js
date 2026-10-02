const express = require("express");
const cors = require("cors");

const app = express();
const PUERTO = 3000;

app.use(cors());
app.use(express.json());

let productos = [
  {
    id: 1,
    nombre: "Chocolate",
    sabor: "Chocolate",
    descripcion: "Helado cremoso de chocolate.",
    precio: 5000
  },
  {
    id: 2,
    nombre: "Vainilla",
    sabor: "Vainilla",
    descripcion: "Helado suave con sabor clásico a vainilla.",
    precio: 4500
  },
  {
    id: 3,
    nombre: "Fresa",
    sabor: "Fresa",
    descripcion: "Helado refrescante con sabor a fresa.",
    precio: 5000
  }
];

/*
  Ruta principal
*/
app.get("/", (req, res) => {
  res.json({
    mensaje: "API de helados funcionando correctamente"
  });
});

/*
  GET - Obtener todos los productos
*/
app.get("/api/productos", (req, res) => {
  res.json(productos);
});

/*
  GET - Obtener un producto por ID
*/
app.get("/api/productos/:id", (req, res) => {
  const id = Number(req.params.id);

  const producto = productos.find(
    (item) => item.id === id
  );

  if (!producto) {
    return res.status(404).json({
      mensaje: "Producto no encontrado"
    });
  }

  res.json(producto);
});

/*
  POST - Crear un nuevo producto
*/
app.post("/api/productos", (req, res) => {
  const {
    nombre,
    sabor,
    descripcion,
    precio
  } = req.body;

  /*
    Validar campos obligatorios
  */
  if (
    !nombre ||
    !sabor ||
    !descripcion ||
    precio === undefined
  ) {
    return res.status(400).json({
      mensaje: "Todos los campos son obligatorios"
    });
  }

  const precioNumerico = Number(precio);

  /*
    Validar precio
  */
  if (
    !Number.isFinite(precioNumerico) ||
    precioNumerico <= 0
  ) {
    return res.status(400).json({
      mensaje: "El precio debe ser un número mayor que cero"
    });
  }

  /*
    Crear nuevo producto
  */
  const nuevoProducto = {
    id: productos.length > 0
      ? Math.max(
          ...productos.map((producto) => producto.id)
        ) + 1
      : 1,

    nombre: String(nombre).trim(),
    sabor: String(sabor).trim(),
    descripcion: String(descripcion).trim(),
    precio: precioNumerico
  };

  productos.push(nuevoProducto);

  res.status(201).json(nuevoProducto);
});

/*
  Iniciar servidor
*/
app.listen(PUERTO, () => {
  console.log(
    `API ejecutándose en http://localhost:${PUERTO}`
  );
});
