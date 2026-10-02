import React from "react";

import {
  IonApp,
  IonRouterOutlet
} from "@ionic/react";

import {
  IonReactRouter
} from "@ionic/react-router";

import {
  Redirect,
  Route
} from "react-router-dom";

import Home from "./pages/Home";
import Detail from "./pages/Detail";

const App: React.FC = () => {
  return (
    <IonApp>

      <IonReactRouter>

        <IonRouterOutlet>

          <Route
            exact
            path="/inicio"
            component={Home}
          />

          <Route
            exact
            path="/productos/:id"
            component={Detail}
          />

          <Route exact path="/">
            <Redirect to="/inicio" />
          </Route>

        </IonRouterOutlet>

      </IonReactRouter>

    </IonApp>
  );
};

export default App;
