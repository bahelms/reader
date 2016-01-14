defmodule Reader.ArticleWorker do
  alias Reader.{Article, Repo}

  def update_title(article) do
    Task.Supervisor.start_child(
      Reader.ArticleWorkerSupervisor, __MODULE__, :fetch_title, [article])
  end

  def fetch_title(article) do
    body = HTTPoison.get!(article.url, [], [follow_redirect: true]).body
    IO.puts inspect body
    [{"title", _, [title|_]} |_] = Floki.find(body, "title")

    Article.changeset(article, %{title: title}) |> Repo.update
  end
end
