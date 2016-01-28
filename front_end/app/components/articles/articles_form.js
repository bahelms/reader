import React from "react";
import Server from "../../utils/server";
import SingleArticleForm from "./single_article_form";
import BulkArticlesForm from "./bulk_articles_form";

export default class ArticlesForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
    this.server = new Server();
  }

  render() {
    return(
      <div>
        <SingleArticleForm server={this.server} />
        <hr />
        <BulkArticlesForm server={this.server} />
      </div>
    );
  }
}

