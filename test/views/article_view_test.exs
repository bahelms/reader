defmodule Reader.ArticleViewTest do
  use Reader.ConnCase, async: true

  test "read_status returns 'Read' when argument is false" do
    assert Reader.ArticleView.read_status(false) == "Read"
  end

  test "read_status returns 'Unread' when argument is true" do
    assert Reader.ArticleView.read_status(true) == "Unread"
  end
end

