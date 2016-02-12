defmodule Reader.ArticleView do
  use Reader.Web, :view

  def render("index.json", %{articles: articles}), do: articles
  def render("show.json", %{article: article}), do: article
  def render("delete.json", %{status: status}), do: %{status: status}

  def render("create.json", %{status: :ok, message: message}) do
    %{status: :ok, message: message}
  end

  def render("create.json", %{status: :error, errors: errors}) do
    %{status: :error, errors: humanize_errors(errors)}
  end

  def render("update.json",  %{status: :ok, article: article}) do
    %{status: :ok, article: article}
  end

  def render("update.json", %{status: :error, errors: errors}) do
    %{status: :error, errors: humanize_errors(errors)}
  end

  def render("create_bulk.json", %{failed_changesets: changesets}) do
    errors = Enum.map changesets, fn(changeset) ->
      "#{changeset.changes.url} has already been taken"
    end
    %{errors: errors}
  end

  def render("random_article.json", %{article_id: id}), do: %{article_id: id}

  defp humanize_errors(errors) do
    for {field, error} <- errors, do: "#{humanize(field)} #{error}"
  end
end

