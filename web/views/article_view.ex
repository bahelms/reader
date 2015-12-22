defmodule Reader.ArticleView do
  use Reader.Web, :view

  def render("index.json", %{articles: articles}), do: articles
  def render("show.json", %{article: article}), do: article
  def render("update.json", %{status: :ok}), do: %{status: :ok}

  def render("update.json", %{status: :error, changeset: changeset}) do
    errors = for {field, error} <- changeset.errors do
      "#{changeset.changes[field]} #{error}"
    end
    %{status: :error, errors: errors}
  end

  # OLD
  def article_status(%{read: true, favorite: false}), do: "info"
  def article_status(%{favorite: true}), do: "success"
  def article_status(_), do: ""

  def status_button(:read, conn, article) do
    button(read_status(article.read),
      to: article_path(conn, :update_status, article),
      method: "put", name: "article[read]", class: "btn btn-info")
  end

  def status_button(:favorite, conn, article) do
    button(favorite_status(article.favorite),
      to: article_path(conn, :update_status, article),
      method: "put", name: "article[favorite]", class: "btn btn-success")
  end

  def read_status(true), do: "Unread"
  def read_status(false), do: "Read"

  def favorite_status(true), do: "Unfavorite"
  def favorite_status(false), do: "Favorite"
end
