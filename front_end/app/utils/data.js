export default class Data {
  constructor() {
    this.url = "http://localhost:4000";
  }

  getArticles(callback) {
    $.get(`${this.url}/articles`, (articles) => {
      callback(articles);
    });
  }

  getArticleCategories(callback) {
    $.get(`${this.url}/article_categories`, (data) => {
      callback(data.categories);
    });
  }
}
