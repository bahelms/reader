import "./main.scss";
import React from "react";
import ReactDOM from "react-dom";
import { Router, Route, IndexRoute, NotFoundRoute } from "react-router";
import { browserHistory } from "react-router";
import App from "./components/app";
import ArticlesIndex from "./components/articles/articles_index";
import ArticleSelector from "./components/articles/article_selector";
import Article from "./components/articles/article";
import ArticlesForm from "./components/articles/articles_form";
import NoMatch from "./components/no_match";

const app = document.createElement("div");
document.body.appendChild(app);

ReactDOM.render((
  <Router history={browserHistory}>
    <Route path="/" component={App}>
      <IndexRoute component={ArticleSelector} />
      <Route path="articles" component={ArticlesIndex} />
      <Route path="articles/new" component={ArticlesForm} />
      <Route path="articles/:id" component={Article} />
      <Route path="*" component={NoMatch} />
    </Route>
  </Router>
), app);
