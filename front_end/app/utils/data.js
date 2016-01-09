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

  getArticle(id, callback) {
    $.get(`${this.url}/articles/${id}`, (article) => {
      callback(article);
    });
  }

  postArticle(params, callback) {
    $.post(`${this.url}/articles`, params, (data) => {
      callback(data);
    });
  }

  putArticle(id, params, callback) {
    $.ajax({
      url: `${this.url}/articles/${id}`,
      type: "PUT",
      data: params,
      success: (response) => { callback(response); },
      failure: (data) => { alert(`Failure: ${data}`); }
    });
  }

  deleteArticle(id, callback) {
    $.ajax({
      url: `${this.url}/articles/${id}`,
      type: "DELETE",
      success: (response) => { callback(response); },
      failure: (data) => { alert(`Failure: ${data}`); }
    });
  }
}
