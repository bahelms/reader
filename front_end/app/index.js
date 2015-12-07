import "./main.scss";
import React from "react";
import ReactDOM from "react-dom";
import { Router, Route } from "react-router";
import App from "./components/layout/app";

const app = document.createElement("div");
document.body.appendChild(app);
// ReactDOM.render(<App backendDomain={backendDomain} />, app);

ReactDOM.render((
  <Router>
    <Route path="/" component={App}>
    </Route>
  </Router>
), app);
