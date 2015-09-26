defmodule Reader.ArticleViewTest do
  use Reader.ConnCase, async: true

  test "article_status returns 'Read' when argument is true" do
    assert Reader.ArticleView.read_status(true) == "Read"
  end

  test "article_status returns 'Not Read' when argument is false" do
    assert Reader.ArticleView.read_status(false) == "Not Read"
  end
end

