defmodule Reader.HomeController do
  use Reader.Web, :controller
  alias Reader.Article

  def index(conn, _params) do
    categories = Article.distinct_categories
      |> Article.unread
      |> Repo.all
    render conn, "index.html", categories: ["random" | categories]
  end
end

