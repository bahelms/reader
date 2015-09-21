defmodule Reader.HomeController do
  use Reader.Web, :controller

  def index(conn, _params) do
    render conn, "index.html", categories: find_categories
  end

  defp find_categories do
    Reader.Article
      |> Reader.Repo.all
      |> Enum.reduce "Random", fn(article, categories) ->
        [categories | [article.category]]
      end
  end
end
