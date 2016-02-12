defmodule Reader.ArticleControllerTest do
  use Reader.ConnCase
  alias Reader.Article
  require Logger

  setup do
    articles = [
      %Article{id: 1, category: "test1", url: "one.com", title: "some title"},
      %Article{id: 2, category: "test1", url: "two.com", title: "some title"},
      %Article{id: 3, category: "test2", url: "three.com", title: "some title"},
      %Article{id: 4, category: "test3", url: "four.com", title: "some title"}
    ]

   ids = Enum.map articles, fn(article) ->
     {:ok, article} = Repo.insert(article)
     article.id
   end

    {:ok, ids: ids}
  end

  ### get /articles ###

  test "returns all articles ordered by category" do
    conn = get conn, article_path(conn, :index)
    {:ok, json} = Poison.decode(conn.resp_body)
    assert json == [
      %{"id" => 1,
        "url" => "one.com",
        "category" => "test1",
        "title" => "some title",
        "read" => false,
        "favorite" => false},
      %{"id" => 2,
        "url" => "two.com",
        "category" => "test1",
        "title" => "some title",
        "read" => false,
        "favorite" => false},
      %{"id" => 3,
        "url" => "three.com",
        "category" => "test2",
        "title" => "some title",
        "read" => false,
        "favorite" => false},
      %{"id" => 4,
        "url" => "four.com",
        "category" => "test3",
        "title" => "some title",
        "read" => false,
        "favorite" => false},
    ]
  end

  ### get /article/:id ###

  test "returns the article for id as json", %{ids: [id | _ids]} do
    conn = get conn, article_path(conn, :show, id)
    {:ok, json} = Poison.decode(conn.resp_body)
    assert json == %{
      "id" => 1,
      "url" => "one.com",
      "category" => "test1",
      "title" => "some title",
      "read" => false,
      "favorite" => false }
  end

  ### get /article_categories ###

  test "returns a unique list of all unread categories in asc order, titleized" do
    conn = get conn, article_path(conn, :article_categories)
    {:ok, json} = Poison.decode(conn.resp_body)
    assert json["categories"] == ["Random", "Test1", "Test2", "Test3"]
  end

  ### post /articles ###

  test "it creates a new article record" do
    url = "http://google.com"
    params = %{article: %{url: url, category: "shrimp"}}
    post conn, article_path(conn, :create, params)
    :timer.sleep(1100)

    article = Repo.get_by(Article, url: url)
    assert article.title == "Google"
  end

  test "when title is nil, it sets default" do
    url = "google.coml"
    params = %{article: %{url: url, category: "shrimp", title: nil}}
    post conn, article_path(conn, :create, params)
    article = Repo.get_by(Article, url: url)
    assert article.title == "NO TITLE"
  end

  test "when title is given, it does not replace it with remote title" do
    url = "http://google.com"
    params = %{article: %{url: url, category: "shrimp", title: "Shrimp Tasty"}}
    post conn, article_path(conn, :create, params)
    :timer.sleep(1000)

    article = Repo.get_by(Article, url: url)
    :timer.sleep(1000)
    assert article.title == "Shrimp Tasty"
  end

  ### post /bulk_articles ###

  test "it creates many article records" do
    params = %{
      bulk_articles: %{
        category: :shrimp,
        urls: "http://google.com\nhttp://yahoo.com\nhttp://lycos.com"
      }
    }
    post conn, article_path(conn, :create_bulk, params)
    :timer.sleep(3000)

    google = Repo.get_by(Article, url: "http://google.com")
    yahoo  = Repo.get_by(Article, url: "http://yahoo.com")
    lycos  = Repo.get_by(Article, url: "http://lycos.com")

    assert google.title == "Google"
    assert google.category == "shrimp"
    assert yahoo.title == "Yahoo"
    assert lycos.title == "Lycos.com"
  end

  test "when a url has already been taken, it responds with errors" do
    params = %{bulk_articles: %{category: :shrimp, urls: "hey.com\nhey.com"}}
    res = post conn, article_path(conn, :create_bulk, params)
    {:ok, %{"errors" => errors}} = Poison.decode(res.resp_body)
    assert errors == ["hey.com has already been taken"]
  end

  test "post /bulk_articles, when title is nil, it sets default" do
    params = %{bulk_articles: %{category: :shrimp, urls: "http://google.goog"}}
    post conn, article_path(conn, :create_bulk, params)
    article = Repo.get_by(Article, url: "http://google.goog")
    assert article.title == "NO TITLE"
  end

  ### put /articles/:id ###

  test "updates the given article" do
    params = %{article: %{url: "update.four.com"}}
    put conn, article_path(conn, :update, %Article{id: 4}), params
    assert Repo.get(Article, 4).url == "update.four.com"
  end

  test "updates favorite status" do
    params = %{article: %{favorite: true}}
    put conn, article_path(conn, :update, %Article{id: 3}), params
    assert Repo.get(Article, 3).favorite == true
  end

  test "updates read status" do
    params = %{article: %{read: true}}
    put conn, article_path(conn, :update, %Article{id: 1}), params
    assert Repo.get(Article, 1).read == true
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
        "title" => "some title",
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
                     "errors" => ["Url has already been taken"]}
  end

  ### delete /articles/:id ###

  test "deletes the given article" do
    delete conn, article_path(conn, :delete, 3)
    assert Repo.one(from a in Article, select: count(a.id)) == 3
  end

  ### get /random_article ###

  test "returns a random article in given category" do
    path = article_path(conn, :random_article, category: :test2)
    {:ok, %{"article_id" => id}} = get(conn, path).resp_body |> Poison.decode
    assert id == 3

    path = article_path(conn, :random_article, category: :test1)
    {:ok, %{"article_id" => id}} = get(conn, path).resp_body |> Poison.decode
    assert id in [1,2]

    path = article_path(conn, :random_article, category: :random)
    {:ok, %{"article_id" => id}} = get(conn, path).resp_body |> Poison.decode
    assert id in [1,2,3,4]
  end
end

