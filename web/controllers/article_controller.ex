defmodule Reader.ArticleController do
  use Reader.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
