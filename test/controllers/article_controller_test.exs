defmodule Reader.ArticleControllerTest do
  use Reader.ConnCase
  alias Reader.Article
  require Logger
  import Ecto.Query

  setup do
    Ecto.Adapters.SQL.Sandbox.mode(Repo, {:shared, self})

    articles = [
      %Article{category: "test1", url: "one.com", title: "some title"},
      %Article{category: "test1", url: "two.com", title: "some title"},
      %Article{category: "test2", url: "three.com", title: "some title"},
      %Article{category: "test3", url: "four.com", title: "some title"},
      %Article{category: "test3", url: "hey.com", title: "some title"}
    ]

   ids = Enum.map articles, fn(article) ->
     {:ok, article} = Repo.insert(article)
     article.id
   end

    {:ok, ids: ids}
  end

  ### GET /articles ###

  test "returns all articles ordered by category" do
    conn = get conn, article_path(conn, :index)
    {:ok, json} = Poison.decode(conn.resp_body)
    articles = json["articles"]
      |> Enum.map(&(Map.drop(&1, ["id", "inserted_at"])))

    assert articles == [
      %{"url" => "one.com",
        "category" => "test1",
        "title" => "some title",
        "read" => false,
        "favorite" => false},
      %{"url" => "two.com",
        "category" => "test1",
        "title" => "some title",
        "read" => false,
        "favorite" => false},
      %{"url" => "three.com",
        "category" => "test2",
        "title" => "some title",
        "read" => false,
        "favorite" => false},
      %{"url" => "four.com",
        "category" => "test3",
        "title" => "some title",
        "read" => false,
        "favorite" => false},
      %{"url" => "hey.com",
        "category" => "test3",
        "title" => "some title",
        "read" => false,
        "favorite" => false},
    ]
  end

  test "returns all unique categories in alphabetical order" do
    conn = get conn, article_path(conn, :index)
    {:ok, json} = Poison.decode(conn.resp_body)
    articles = json["categories"]
    assert json["categories"] == ["test1", "test2", "test3"]
  end

  ### GET /article/:id ###

  test "returns the requested article as json", %{ids: [id | _ids]} do
    inserted_at = Repo.get(Article, id).inserted_at |> Ecto.DateTime.to_iso8601
    conn = get conn, article_path(conn, :show, id)
    {:ok, json} = Poison.decode(conn.resp_body)
    article_json = Map.delete(json, "id")

    assert article_json == %{
      "url" => "one.com",
      "category" => "test1",
      "title" => "some title",
      "read" => false,
      "favorite" => false,
      "inserted_at" => inserted_at}
  end

  ### GET /article_categories ###

  test "returns a unique list of all unread categories in asc order, titleized" do
    conn = get conn, article_path(conn, :article_categories)
    {:ok, json} = Poison.decode(conn.resp_body)
    assert json["categories"] == ["Random", "Test1", "Test2", "Test3"]
  end

  ### POST /articles ###

  test "it creates a new article record" do
    url = "http://google.com"
    params = %{article: %{url: url, category: "Shrimp Test"}}
    post conn, article_path(conn, :create, params)
    :timer.sleep(1100)

    article = Repo.get_by(Article, url: url)
    assert article.title == "Google"
    assert article.category == "shrimp_test"
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

  test "it removes extra query string crap from url" do
    url = "http://www.test.com?utm_source=rubyweekly&utm_medium=email"
    params = %{article: %{url: url, category: "octopoid"}}
    post conn, article_path(conn, :create, params)

    assert Repo.get_by(Article, url: "http://www.test.com")
  end

  ### POST /bulk_articles ###

  test "it creates many article records" do
    params = %{
      bulk_articles: %{
        category: "Bonkers",
        urls: "http://google.com\nhttp://yahoo.com\nhttp://lycos.com"
      }
    }
    post conn, article_path(conn, :create_bulk, params)
    :timer.sleep(3000)

    google = Repo.get_by(Article, url: "http://google.com")
    yahoo  = Repo.get_by(Article, url: "http://yahoo.com")
    lycos  = Repo.get_by(Article, url: "http://lycos.com")

    assert google.title == "Google"
    assert google.category == "bonkers"
    assert yahoo.title == "Yahoo"
    assert lycos.title == "Lycos.com"
  end

  test "when a url has already been taken, it responds with errors" do
    params = %{bulk_articles: %{category: :shrimp, urls: "hey.com"}}
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

  test "removes query string crap from all urls" do
    urls = [
      "http://google.com?hey=there",
      "http://yahoo.com?hey=there&what=now",
      "http://lycos.com?go=away"
    ] |> Enum.join("\n")

    params = %{bulk_articles: %{category: "Boo Boo Pie", urls: urls}}
    post conn, article_path(conn, :create_bulk, params)

    assert Repo.get_by(Article, url: "http://google.com")
    assert Repo.get_by(Article, url: "http://yahoo.com")
    assert Repo.get_by(Article, url: "http://lycos.com")
  end

  ### PUT /articles/:id ###

  test "updates the given article", %{ids: [id | _ids]} do
    params = %{article: %{url: "update.four.com", category: "hey There"}}
    put conn, article_path(conn, :update, %Article{id: id}), params
    article = Repo.get(Article, id)
    assert article.url == "update.four.com"
    assert article.category == "hey_there"
  end

  test "updates favorite status", %{ids: [id | _ids]} do
    params = %{article: %{favorite: true}}
    put conn, article_path(conn, :update, %Article{id: id}), params
    assert Repo.get(Article, id).favorite == true
  end

  test "updates read status", %{ids: [id | _ids]} do
    params = %{article: %{read: true}}
    put conn, article_path(conn, :update, %Article{id: id}), params
    assert Repo.get(Article, id).read == true
  end

  test "returns a status of 'ok' upon update", %{ids: [id | _ids]} do
    inserted_at = Repo.get(Article, id).inserted_at |> Ecto.DateTime.to_iso8601
    params = %{article: %{url: "a new URL"}}
    conn = put conn, article_path(conn, :update, %Article{id: id}), params
    {:ok, json} = Poison.decode(conn.resp_body)

    assert json == %{
      "status" => "ok",
      "article" => %{
        "id" => id,
        "category" => Repo.get(Article, id).category,
        "url" => "a new URL",
        "title" => "some title",
        "read" => false,
        "favorite" => false,
        "inserted_at" => inserted_at
      }
    }
  end

  test "returns a status of 'error' with a reason upon update" do
    old_article = Article |> where(url: "one.com") |> Repo.first
    params = %{article: %{url: "two.com"}}
    conn = put conn, article_path(conn, :update, old_article), params
    {:ok, json} = Poison.decode(conn.resp_body)

    assert json == %{
      "status" => "error",
      "errors" => ["Url has already been taken"]}
  end

  ### DELETE /articles/:id ###

  test "deletes the given article", %{ids: [id | _ids]} do
    delete conn, article_path(conn, :delete, id)
    assert Repo.all(Article) |> Enum.count == 4
  end

  ### GET /random_article ###

  test "returns a random article in given category" do
    article = Article |> where(category: "test2") |> Repo.first
    path = article_path(conn, :random_article, category: :test2)
    {:ok, %{"article_id" => id}} = get(conn, path).resp_body |> Poison.decode
    assert id == article.id

    articles = Article |> where(category: "test1") |> Repo.all
    path = article_path(conn, :random_article, category: :test1)
    {:ok, %{"article_id" => id}} = get(conn, path).resp_body |> Poison.decode
    assert id in Enum.map(articles, fn(a) -> a.id end)

    articles = Repo.all(Article)
    path = article_path(conn, :random_article, category: :random)
    {:ok, %{"article_id" => id}} = get(conn, path).resp_body |> Poison.decode
    assert id in Enum.map(articles, fn(a) -> a.id end)
  end
end

