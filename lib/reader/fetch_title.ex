defmodule Reader.ArticleWorker do
  alias Reader.Article
  alias Reader.Repo
  import Logger

  def update_title(article) do
    Task.Supervisor.start_child(
      Reader.ArticleWorkerSupervisor, __MODULE__, :fetch_title, [article])
  end

  def fetch_title(article) do
    [{"title", _, [title|_]} |_] = HTTPoison.get!(article.url).body
      |> Floki.find("title")

    Article.changeset(article, %{title: title})
      |> Repo.update
  end
end
