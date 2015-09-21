defmodule Reader.HomeController do
  use Reader.Web, :controller

  def index(conn, _params) do
    categories = ["random" | Reader.Repo.all(Reader.Article.distinct_categories)]
    render conn, "index.html", categories: categories
  end
end
