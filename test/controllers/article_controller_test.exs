defmodule Reader.ArticleControllerTest do
  use Reader.ConnCase
  alias Reader.Article
  require Logger
  import Ecto.Query

  setup do
    ids = [%Article{id: 1, category: "test1", url: "one.com"},
           %Article{id: 2, category: "test1", url: "two.com"},
           %Article{id: 3, category: "test2", url: "three.com"},
           %Article{id: 4, category: "test3", url: "four.com"}]
         |> Enum.map fn(article) ->
           {:ok, article} = Repo.insert(article)
           article.id
         end

    {:ok, ids: ids}
  end

  @doc "get /articles"
  test "returns all articles ordered by category" do
    conn = get conn, article_path(conn, :index)
    {:ok, json} = Poison.decode(conn.resp_body)
    assert json == [
      %{"id" => 1,
        "url" => "one.com",
        "category" => "test1",
        "title" => nil,
        "read" => false,
        "favorite" => false},
      %{"id" => 2,
        "url" => "two.com",
        "category" => "test1",
        "title" => nil,
        "read" => false,
        "favorite" => false},
      %{"id" => 3,
        "url" => "three.com",
        "category" => "test2",
        "title" => nil,
        "read" => false,
        "favorite" => false},
      %{"id" => 4,
        "url" => "four.com",
        "category" => "test3",
        "title" => nil,
        "read" => false,
        "favorite" => false},
    ]
  end

  @doc "get /article/:id"
  test "returns the article for id as json", %{ids: [id | ids]} do
    conn = get conn, article_path(conn, :show, id)
    {:ok, json} = Poison.decode(conn.resp_body)
    assert json == %{
      "id" => 1,
      "url" => "one.com",
      "category" => "test1",
      "title" => nil,
      "read" => false,
      "favorite" => false }
  end

  @doc "get /article_categories"
  test "returns a unique list of all unread categories in asc order, titleized" do
    conn = get conn, article_path(conn, :article_categories)
    {:ok, json} = Poison.decode(conn.resp_body)
    assert json["categories"] == ["Random", "Test1", "Test2", "Test3"]
  end

  @doc "post /articles"
  test "creates a new article record" do
    params = %{
      article: %{
        title: "hey there", url: "http://hey-there.com", category: "shrimp"
      }
    }
    conn = post conn, article_path(conn, :create, params)
    article = Repo.get_by(Article, url: "http://hey-there.com")
    assert article != nil
  end

  @doc "put /articles/:id"
  test "updates the given article" do
    params = %{article: %{url: "update.four.com"}}
    conn = put conn, article_path(conn, :update, %Article{id: 4}), params
    assert Repo.get(Article, 4).url == "update.four.com"
  end

  test "returns a status of 'ok' upon update" do
    params = %{article: %{url: "a new URL"}}
    conn = put conn, article_path(conn, :update, %Article{id: 4}), params
    {:ok, json} = Poison.decode(conn.resp_body)
    assert json == %{
      "status" => "ok",
      "article" => %{
        "id" => 4,
        "category" => "test3",
        "url" => "a new URL",
        "title" => nil,
        "read" => false,
        "favorite" => false
      }
    }
  end

  test "returns a status of 'error' with a reason upon update" do
    params = %{article: %{url: "one.com"}}
    conn = put conn, article_path(conn, :update, %Article{id: 4}), params
    {:ok, json} = Poison.decode(conn.resp_body)
    assert json == %{"status" => "error",
                     "errors" => ["url has already been taken"]}
  end
end

