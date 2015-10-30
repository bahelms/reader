import React from "react";
import Header from "./header";
import ArticleSelector from "../article_selector";

export default class App extends React.Component {
  render() {
    return (
      <section className="container-fluid">
        <Header />
        <ArticleSelector url="/article_categories" />
      </section>
    );
  }
}
