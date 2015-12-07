import React from "react";
import Header from "./header";
import ArticleSelector from "../article_selector";

const BACKEND_DOMAIN = "http://localhost:4000"

export default class App extends React.Component {
  render() {
    return (
      <section className="container-fluid">
        <Header />
        <ArticleSelector url={`${BACKEND_DOMAIN}/article_categories`} />
      </section>
    );
  }
}
