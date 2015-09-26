class ArticleController {
  constructor() {
    this.bind_events();
  }

  bind_events() {
    this.show_article();
  }

  show_article() {
    $("[data-behavior=show_article]").click((event) => {
      console.log(`/articles/${event.target.id}`);
      window.location.href = `/articles/${event.target.id}`;
      // $.get(`/articles/${event.target.id}`, (
    });
  }
}

export default ArticleController
