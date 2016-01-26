import React from "react";
import SingleArticleForm from "./single_article_form";
import BulkArticlesForm from "./bulk_articles_form";

export default class ArticlesForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  handleCreateArticle(event) {
    event.preventDefault();
    // post article
    // update flash
    alert("To be continued...");
  }

  render() {
    return(
      <div>
        <SingleArticleForm createArticle={this.handleCreateArticle}/>
        <hr />
        <BulkArticlesForm createArticles={this.handleCreateArticle}/>
      </div>
    );
  }
}

