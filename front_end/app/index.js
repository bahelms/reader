import "./main.css";
import React from "react";
import ReactDOM from "react-dom";
import Element from "./components/element";

const app = document.createElement("div");
document.body.appendChild(app);
ReactDOM.render(<Element />, app);

