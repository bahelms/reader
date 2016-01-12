import React from "react";
import SingleArticleForm from "./single_article_form";
import BulkArticlesForm from "./bulk_articles_form";

export default class ArticlesForm extends React.Component {
  render() {
    return(
      <div>
        <SingleArticleForm />
        <hr />
        <BulkArticlesForm />
      </div>
    );
  }
}

