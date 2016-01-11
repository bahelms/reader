defmodule Reader.ArticleView do
  use Reader.Web, :view

  def render("index.json", %{articles: articles}), do: articles
  def render("show.json", %{article: article}), do: article
  def render("delete.json", %{status: status}), do: %{status: status}
  def render("update.json", a = %{status: :ok, article: article}) do
    %{status: :ok, article: article}
  end

  def render("update.json", %{status: :error, errors: errors}) do
    errors = for {field, error} <- errors, do: "#{field} #{error}"
    %{status: :error, errors: errors}
  end
end
