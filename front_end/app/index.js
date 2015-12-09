import "./main.scss";
import React from "react";
import ReactDOM from "react-dom";
import { Router, Route, IndexRoute } from "react-router";
import App from "./components/app";
import ArticleIndex from "./components/articles/article_index"
import ArticleSelector from "./components/articles/article_selector"

const app = document.createElement("div");
document.body.appendChild(app);
// ReactDOM.render(<App backendDomain={backendDomain} />, app);

ReactDOM.render((
  <Router>
    <Route path="/" component={App}>
      <IndexRoute component={ArticleSelector} />
      <Route path="/articles" component={ArticleIndex} />
    </Route>
  </Router>
), app);
