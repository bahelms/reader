import React from "react";
import Server from "../../utils/server";
import ArticlesTable from "./articles_table";
import ArticleSort from "./article_sort";

export default class ArticlesIndex extends React.Component {
  constructor(props) {
    super(props);
    this.state = {articles: [], filteredArticles: []};
    this.server = new Server();
  }

  componentDidMount() {
    this.server.getArticles((articles) => {
      this.setState({
        articles: articles,
        filteredArticles: this.filterArticlesByCategory(
          articles,
          articles[0].category
        )
      });
    });
  }

  articleCategories() {
    const set =  new Set(this.state.articles.map((article) => {
      return article.category;
    }));
    return Array.from(set);
  }

  filterArticlesByCategory(articles, category) {
    return articles.filter((article) => {
      return article.category === category;
    });
  }

  handleCategoryChange(event) {
    this.setState({
      filteredArticles: this.filterArticlesByCategory(
        this.state.articles,
        event.target.value
      )
    });
  }

  render() {
    return(
      <section>
        <ArticleSort
          categories={this.articleCategories()}
          handleCategoryChange={this.handleCategoryChange.bind(this)} />
        <ArticlesTable articles={this.state.filteredArticles} />
      </section>
    );
  }
}
