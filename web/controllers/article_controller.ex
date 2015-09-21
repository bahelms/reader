defmodule Reader.ArticleController do
  use Reader.Web, :controller
  alias Reader.Article

  def index(conn, _params) do
    articles = Reader.Repo.all(Article.articles_by_category)
    render conn, :index, articles: articles
  end

  def new(conn, _params) do
    render conn, :new
  end
end

