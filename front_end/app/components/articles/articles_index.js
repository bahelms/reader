import React from "react";
import Server from "../../utils/server";
import ArticlesTable from "./articles_table";
import ArticleSort from "./article_sort";

export default class ArticlesIndex extends React.Component {
  constructor(props) {
    super(props);
    this.state = {articles: []};
    this.server = new Server();
  }

  componentDidMount() {
    this.server.getArticles((articles) => {
      this.setState({articles: articles});
    });
  }

  articleCategories() {
    const set =  new Set(this.state.articles.map((article) => {
      return article.category;
    }));
    return Array.from(set);
  }

  handleCategoryChange(event) {
    const articles = this.state.articles.filter((article) => {
      return article.category === event.target.value;
    });
    this.setState({articles: articles});
  }

  render() {
    return(
      <section>
        <ArticleSort
          categories={this.articleCategories()}
          handleCategoryChange={this.handleCategoryChange.bind(this)} />
        <ArticlesTable articles={this.state.articles} />
      </section>
    );
  }
}
