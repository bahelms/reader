import "./main.scss";
import React from "react";
import ReactDOM from "react-dom";
import App from "./components/layout/app";

const backendDomain = "http://localhost:4000"

const app = document.createElement("div");
document.body.appendChild(app);
ReactDOM.render(<App backendDomain={backendDomain} />, app);

