import React from "react";
import Header from "./layout/header";
import ArticleSelector from "./articles/article_selector";

export default class App extends React.Component {
  render() {
    console.log(this.props.children);
    return (
      <section className="container-fluid">
        <Header />
        {this.props.children}
      </section>
    );
  }
}
