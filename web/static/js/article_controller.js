class ArticleController {
  constructor() {
    this.bind_events();
  }

  bind_events() {
    this.show_article();
    this.confirm_delete();
  }

  show_article() {
    $("[data-behavior=show_article]").click((event) => {
      window.location.href = `/articles/${event.target.id}`;
    });
  }

  confirm_delete() {
    $("[data-behavior=confirm]").click((event) => {
      let res = confirm("Are you sure you want to delete this article?");
      if (!res) event.preventDefault();
    });
  }
}

export default ArticleController

