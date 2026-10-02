import React from "react";
import ReactDOM from "react-dom/client";

import { setupIonicReact } from "@ionic/react";

/*
  Estilos principales de Ionic
*/
import "@ionic/react/css/core.css";
import "@ionic/react/css/normalize.css";
import "@ionic/react/css/structure.css";
import "@ionic/react/css/typography.css";
import "@ionic/react/css/padding.css";
import "@ionic/react/css/flex-utils.css";
import "@ionic/react/css/display.css";

/*
  Variables de la aplicación
*/
import "./theme/variables.css";

/*
  Aplicación principal
*/
import App from "./App";

setupIonicReact();

ReactDOM.createRoot(
  document.getElementById("root")!
).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
