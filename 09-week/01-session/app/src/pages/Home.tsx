import React, {
  FormEvent,
  useEffect,
  useState
} from "react";

import {
  IonButton,
  IonCard,
  IonCardContent,
  IonCardHeader,
  IonCardTitle,
  IonContent,
  IonHeader,
  IonInput,
  IonItem,
  IonLabel,
  IonList,
  IonLoading,
  IonPage,
  IonText,
  IonTitle,
  IonToolbar
} from "@ionic/react";

import {
  useHistory
} from "react-router-dom";

import "./Home.css";

/*
  Interface de un producto
*/
interface Producto {
  id: number;
  nombre: string;
  sabor: string;
  descripcion: string;
  precio: number;
}

/*
  Dirección de nuestra API
*/
const API_URL =
  "http://localhost:3000/api/productos";

const Home: React.FC = () => {

  const history = useHistory();

  /*
    Estado de los productos
  */
  const [
    productos,
    setProductos
  ] = useState<Producto[]>([]);

  /*
    Estado del formulario
  */
  const [
    nombre,
    setNombre
  ] = useState("");

  const [
    sabor,
    setSabor
  ] = useState("");

  const [
    descripcion,
    setDescripcion
  ] = useState("");

  const [
    precio,
    setPrecio
  ] = useState("");

  /*
    Estados de carga
  */
  const [
    cargando,
    setCargando
  ] = useState(false);

  const [
    guardando,
    setGuardando
  ] = useState(false);

  /*
    Estado para errores
  */
  const [
    error,
    setError
  ] = useState("");

  /*
    Obtener productos desde la API
  */
  const cargarProductos = async () => {

    setCargando(true);
    setError("");

    try {

      const respuesta =
        await fetch(API_URL);

      if (!respuesta.ok) {
        throw new Error(
          "No fue posible obtener los productos."
        );
      }

      const datos: Producto[] =
        await respuesta.json();

      setProductos(datos);

    } catch (error) {

      console.error(error);

      setError(
        "No se pudo conectar con la API. " +
        "Verifica que el servidor esté ejecutándose " +
        "en el puerto 3000."
      );

    } finally {

      setCargando(false);
    }
  };

  /*
    Cargar productos cuando inicia la pantalla
  */
  useEffect(() => {

    cargarProductos();

  }, []);

  /*
    Crear un nuevo producto
  */
  const manejarFormulario = async (
    evento: FormEvent
  ) => {

    evento.preventDefault();

    setError("");

    /*
      Validar campos
    */
    if (
      !nombre ||
      !sabor ||
      !descripcion ||
      !precio
    ) {

      setError(
        "Completa todos los campos."
      );

      return;
    }

    const precioNumerico =
      Number(precio);

    /*
      Validar precio
    */
    if (
      !Number.isFinite(precioNumerico) ||
      precioNumerico <= 0
    ) {

      setError(
        "El precio debe ser un número mayor que cero."
      );

      return;
    }

    setGuardando(true);

    try {

      /*
        Enviar información a la API
      */
      const respuesta =
        await fetch(API_URL, {

          method: "POST",

          headers: {
            "Content-Type": "application/json"
          },

          body: JSON.stringify({

            nombre,

            sabor,

            descripcion,

            precio: precioNumerico

          })

        });

      const datos =
        await respuesta.json();

      if (!respuesta.ok) {

        throw new Error(
          datos.mensaje ||
          "No fue posible crear el producto."
        );
      }

      /*
        Agregar producto a la lista
      */
      setProductos(
        (actuales) => [
          ...actuales,
          datos
        ]
      );

      /*
        Limpiar formulario
      */
      setNombre("");
      setSabor("");
      setDescripcion("");
      setPrecio("");

    } catch (error) {

      console.error(error);

      setError(

        error instanceof Error

          ? error.message

          : "Ocurrió un error al crear el producto."

      );

    } finally {

      setGuardando(false);
    }
  };

  /*
    Ir al detalle
  */
  const verDetalle = (
    id: number
  ) => {

    history.push(
      `/productos/${id}`
    );
  };

  return (

    <IonPage>

      <IonHeader>

        <IonToolbar>

          <IonTitle>
            Heladería
          </IonTitle>

        </IonToolbar>

      </IonHeader>

      <IonContent
        fullscreen
        className="pagina-inicio"
      >

        <div className="contenedor">

          {/* FORMULARIO */}

          <IonCard>

            <IonCardHeader>

              <IonCardTitle>
                Crear nuevo producto
              </IonCardTitle>

            </IonCardHeader>

            <IonCardContent>

              <form
                onSubmit={
                  manejarFormulario
                }
              >

                <IonItem>

                  <IonLabel position="stacked">
                    Nombre
                  </IonLabel>

                  <IonInput
                    value={nombre}
                    placeholder="Ej. Chocolate"
                    onIonInput={(e) =>
                      setNombre(
                        e.detail.value ?? ""
                      )
                    }
                  />

                </IonItem>

                <IonItem>

                  <IonLabel position="stacked">
                    Sabor
                  </IonLabel>

                  <IonInput
                    value={sabor}
                    placeholder="Ej. Chocolate"
                    onIonInput={(e) =>
                      setSabor(
                        e.detail.value ?? ""
                      )
                    }
                  />

                </IonItem>

                <IonItem>

                  <IonLabel position="stacked">
                    Descripción
                  </IonLabel>

                  <IonInput
                    value={descripcion}
                    placeholder="Describe el producto"
                    onIonInput={(e) =>
                      setDescripcion(
                        e.detail.value ?? ""
                      )
                    }
                  />

                </IonItem>

                <IonItem>

                  <IonLabel position="stacked">
                    Precio
                  </IonLabel>

                  <IonInput
                    type="number"
                    min="1"
                    value={precio}
                    placeholder="Ej. 5000"
                    onIonInput={(e) =>
                      setPrecio(
                        e.detail.value ?? ""
                      )
                    }
                  />

                </IonItem>

                <IonButton
                  expand="block"
                  type="submit"
                  className="boton-formulario"
                >
                  Crear producto
                </IonButton>

              </form>

            </IonCardContent>

          </IonCard>

          {/* MENSAJE DE ERROR */}

          {error && (

            <IonText color="danger">

              <p className="mensaje-error">
                {error}
              </p>

            </IonText>

          )}

          {/* LISTA */}

          <div className="encabezado-lista">

            <h2>
              Productos
            </h2>

            <IonButton
              fill="outline"
              onClick={
                cargarProductos
              }
            >
              Actualizar
            </IonButton>

          </div>

          <IonList>

            {productos.map(
              (producto) => (

                <IonCard
                  key={producto.id}
                >

                  <IonCardHeader>

                    <IonCardTitle>
                      {producto.nombre}
                    </IonCardTitle>

                  </IonCardHeader>

                  <IonCardContent>

                    <p>
                      <strong>
                        Sabor:
                      </strong>{" "}
                      {producto.sabor}
                    </p>

                    <p>
                      <strong>
                        Descripción:
                      </strong>{" "}
                      {producto.descripcion}
                    </p>

                    <p>

                      <strong>
                        Precio:
                      </strong>{" "}

                      {producto.precio.toLocaleString(
                        "es-CO",
                        {
                          style: "currency",
                          currency: "COP",
                          maximumFractionDigits: 0
                        }
                      )}

                    </p>

                    <IonButton
                      fill="clear"
                      onClick={() =>
                        verDetalle(
                          producto.id
                        )
                      }
                    >
                      Ver detalle
                    </IonButton>

                  </IonCardContent>

                </IonCard>

              )
            )}

          </IonList>

          {!cargando &&
            productos.length === 0 &&
            !error && (

              <p className="sin-productos">
                No hay productos registrados.
              </p>

            )}

        </div>

        <IonLoading
          isOpen={
            cargando ||
            guardando
          }
          message="Cargando..."
        />

      </IonContent>

    </IonPage>
  );
};

export default Home;
