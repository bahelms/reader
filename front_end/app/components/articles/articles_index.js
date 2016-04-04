import React from "react";
import Server from "../../utils/server";
import ArticlesTable from "./articles_table";
import ArticleSort from "./article_sort";

export default class ArticlesIndex extends React.Component {
  constructor(props) {
    super(props);
    this.state = {articles: [], filteredArticles: [], categories: []};
    this.server = new Server();
  }

  componentDidMount() {
    this.server.getArticles((data) => {
      this.setState({
        articles: data.articles,
        categories: this.articleCategories(data.categories),
        sortCategory: data.categories[0],
        filteredArticles: this.filterArticlesByCategory(
          data.articles,
          data.categories[0]
        )
      });
    });
  }

  articleCategories(categories) {
    let temp = categories.slice(0);
    temp.unshift("all");
    return temp;
  }

  filterArticlesByCategory(articles, category) {
    if (category === "all")
      return articles;
    else {
      return articles.filter((article) => {
        return article.category === category;
      });
    }
  }

  handleCategoryChange(event) {
    this.setState({
      sortCategory: event.target.value,
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
          categories={this.state.categories}
          sortCategory={this.state.sortCategory}
          handleCategoryChange={this.handleCategoryChange.bind(this)} />
        <ArticlesTable articles={this.state.filteredArticles} />
      </section>
    );
  }
}
