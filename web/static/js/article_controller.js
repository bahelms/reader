class ArticleController {
  constructor() {
    this.bind_events();
  }

  bind_events() {
    this.show_article();
  }

  show_article() {
    $("[data-behavior=show_article]").click((event) => {
      window.location.href = `/articles/${event.target.id}`;
    });
  }

  confirm_delete() {
  }
}

export default ArticleController

