class Home {
  static init() {
    $("#show_article_btn").click(function() {
      let category = $("[data-role=category_select]").val();
      $.get("/articles", {category: category}, function(html) {
        $("[data-role=article_container]").html(html);
      });
    });
  }
}

export default Home

