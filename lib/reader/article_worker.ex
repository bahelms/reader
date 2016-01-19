defmodule Reader.ArticleWorker do
  alias Reader.{Article, Repo}

  def update_title(article) do
    Task.Supervisor.start_child(
      Reader.ArticleWorkerSupervisor, __MODULE__, :update_article_title, [article])
  end

  @spec update_article_title(Article.t) :: Article.t
  def update_article_title(article) do
    title = _fetch_title(article.url) |> _parse_title
    Article.changeset(article, %{title: title}) |> Repo.update
  end

  defp _fetch_title(url) do
    HTTPoison.get!(url) |> _redirect
  end

  defp _redirect(%HTTPoison.Response{status_code: 301} = response) do
    {"Location", url} = response.headers |> List.keyfind("Location", 0)
    _fetch_title(url)
  end

  defp _redirect(response), do: response

  defp _parse_title(response) do
    [{"title", _, [title|_]} |_] = Floki.find(response.body, "title")
  end
end
