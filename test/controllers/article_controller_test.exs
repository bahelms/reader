defmodule Reader.ArticleControllerTest do
  use Reader.ConnCase
  alias Reader.Article
  require Logger

  setup do
    Repo.delete_all(Article)
    {:ok, []}
  end

  test "index with a category redirects to show article" do
    {:ok, article} = %Article{url: "test.com", category: "test"} |> Repo.insert
    conn = get conn, article_path(conn, :index, category: "test")
    assert redirected_to(conn) == article_path(conn, :show, article)
  end
end

