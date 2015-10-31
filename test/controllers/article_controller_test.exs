defmodule Reader.ArticleControllerTest do
  use Reader.ConnCase
  alias Reader.Article
  require Logger

  setup do
    [%Article{category: "test1", url: "one.com"},
     %Article{category: "test1", url: "two.com"},
     %Article{category: "test2", url: "three.com"},
     %Article{category: "test3", url: "four.com"}] |>
    Enum.each(fn(article) -> Repo.insert(article) end)

    {:ok, []}
  end

  @doc "get /article_categories"
  test "returns a unique list of all unread categories in asc order" do
    conn = get conn, article_path(conn, :article_categories)
    {:ok, json} = Poison.decode(conn.resp_body)
    assert json["categories"] == ["test1", "test2", "test3"]
  end
end

