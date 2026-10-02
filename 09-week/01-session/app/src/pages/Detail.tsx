import React, {
  useEffect,
  useState
} from "react";

import {
  IonBackButton,
  IonButtons,
  IonCard,
  IonCardContent,
  IonContent,
  IonHeader,
  IonLoading,
  IonPage,
  IonText,
  IonTitle,
  IonToolbar
} from "@ionic/react";

import {
  RouteComponentProps
} from "react-router-dom";

import "./Detail.css";

interface Producto {
  id: number;
  nombre: string;
  sabor: string;
  descripcion: string;
  precio: number;
}

interface Props
  extends RouteComponentProps<{
    id: string;
  }> {}

const Detail: React.FC<Props> = ({
  match
}) => {

  const [
    producto,
    setProducto
  ] = useState<Producto | null>(null);

  const [
    cargando,
    setCargando
  ] = useState(true);

  const [
    error,
    setError
  ] = useState("");

  useEffect(() => {

    const cargarDetalle =
      async () => {

        setCargando(true);
        setError("");

        try {

          const respuesta =
            await fetch(
              `http://localhost:3000/api/productos/${match.params.id}`
            );

          const datos =
            await respuesta.json();

          if (!respuesta.ok) {

            throw new Error(
              datos.mensaje ||
              "Producto no encontrado."
            );
          }

          setProducto(datos);

        } catch (error) {

          console.error(error);

          setError(

            error instanceof Error

              ? error.message

              : "No se pudo cargar el detalle."

          );

        } finally {

          setCargando(false);
        }
      };

    cargarDetalle();

  }, [match.params.id]);

  return (

    <IonPage>

      <IonHeader>

        <IonToolbar>

          <IonButtons slot="start">

            <IonBackButton
              defaultHref="/inicio"
              text="Volver"
            />

          </IonButtons>

          <IonTitle>
            Detalle
          </IonTitle>

        </IonToolbar>

      </IonHeader>

      <IonContent fullscreen>

        <div className="detalle-contenedor">

          {error && (

            <IonText color="danger">

              <p className="mensaje-error">
                {error}
              </p>

            </IonText>

          )}

          {producto && (

            <IonCard>

              <IonCardContent>

                <h1>
                  {producto.nombre}
                </h1>

                <p>
                  <strong>
                    ID:
                  </strong>{" "}
                  {producto.id}
                </p>

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

              </IonCardContent>

            </IonCard>

          )}

        </div>

        <IonLoading
          isOpen={cargando}
          message="Cargando detalle..."
        />

      </IonContent>

    </IonPage>
  );
};

export default Detail;
