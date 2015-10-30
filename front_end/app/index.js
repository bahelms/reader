import "./main.scss";
import React from "react";
import ReactDOM from "react-dom";
import App from "./components/layout/app";

const app = document.createElement("div");
document.body.appendChild(app);
ReactDOM.render(<App />, app);

