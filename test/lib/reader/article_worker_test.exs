defmodule Reader.ArticleWorkerTest do
  use ExUnit.Case
  alias Reader.{Repo, Article, ArticleWorker}

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)

    {:ok, article} = %Article{url: "http://docker.io", category: "test"}
      |> Repo.insert
    {:ok, article: article}
  end

  test "fetch_title/1 retrieves the html title and updates the article", %{article: article} do
    {:ok, article} = ArticleWorker.update_article_title(article)
    assert Regex.match?(~r/Docker/, article.title)
  end
end
