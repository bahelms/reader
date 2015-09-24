defmodule Reader.ArticleController do
  use Reader.Web, :controller
  alias Reader.Article
  import Logger


  def index(conn, %{"category" => category}) do
    render conn, "_article_data.html", article: pluck_article(category)
  end

  def index(conn, _params) do
    articles = Reader.Repo.all(Article.articles_by_category)
    render conn, :index, articles: articles
  end

  def new(conn, _params) do
    render conn, :new
  end

  defp pluck_article("random") do
    :random.seed(:os.timestamp)

    Article.unread
      |> Reader.Repo.all
      |> Enum.shuffle
      |> List.first
  end

  defp pluck_article(category) do
    :random.seed(:os.timestamp)

    Article.in_category(category)
      |> Article.unread
      |> Reader.Repo.all
      |> Enum.shuffle
      |> List.first
  end
end

