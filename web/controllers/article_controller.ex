defmodule Reader.ArticleController do
  use Reader.Web, :controller
  alias Reader.{Article, BulkArticles}
  import Ecto.Query

  plug :scrub_params, "article" when action in [:create, :update]
  plug :scrub_params, "bulk_articles" when action in [:create_bulk]

  def index(conn, _params) do
    render conn, articles: Repo.all(Article.articles_by_category)
  end

  def show(conn, %{"id" => id}) do
    render conn, article: Repo.get!(Article, id)
  end

  def create(conn, %{"article" => params}) do
    changeset = Article.changeset(%Article{}, _filter(params))

    case Repo.insert(changeset) do
      {:ok, article} ->
        if article.title == "NO TITLE" do
          Reader.ArticleWorker.update_title(article)
        end
        render conn, status: :ok, message: "Article saved"
      {:error, changeset} ->
        render conn, status: :error, errors: changeset.errors
    end
  end

  def create_bulk(conn, %{"bulk_articles" => params}) do
  # def create_bulk(conn, %{"articles" => urls, "category" => category}) do
    changesets = BulkArticles.parse(params["urls"], params["category"])
    # changesets = BulkArticles.parse(urls, category)
      |> BulkArticles.to_changesets
      |> Stream.map(fn(changeset) -> Repo.insert(changeset) end)
      |> Enum.reduce([], &_handle_bulk_result/2)
    render conn, failed_changesets: changesets
  end

  def delete(conn, %{"id" => id}) do
    Article
      |> where([a], a.id == ^id)
      |> Repo.delete_all
    render conn, status: :success
  end

  def update(conn, %{"id" => id, "article" => params}) do
    article = Repo.get!(Article, id)
    changeset = Article.changeset(article, params)

    case Repo.update(changeset) do
      {:ok, article} ->
        render conn, status: :ok, article: article
      {:error, changeset} ->
        render conn, status: :error, errors: changeset.errors
    end
  end

  def article_categories(conn, _params) do
    categories = Article.distinct_categories
      |> Article.unread
      |> Article.ordered_by_category
      |> Repo.all
      |> Enum.map(&_titleize/1)
    json conn, %{categories: ["Random" | categories]}
  end

  defp _titleize(string) do
    string
      |> String.split("_")
      |> Enum.map(&(String.capitalize(&1)))
      |> Enum.join(" ")
  end

  defp _filter(params) do
    cond do
      params["title"] == nil -> Map.drop(params, ["title"])
      true                   -> params
    end
  end

  defp _handle_bulk_result(result, acc) do
    case result do
      {:ok, article} ->
        if article.title == "NO TITLE" do
          Reader.ArticleWorker.update_title(article)
        end
        acc
      {:error, changeset} ->
        [changeset | acc]
    end
  end

  # def index(conn, %{"category" => category}) do
  #   article_id = pluck_article(String.downcase(category)).id
  #   redirect conn, to: "/articles/#{article_id}"
  # end

  # defp pluck_article("random") do
  #   :random.seed(:os.timestamp)

  #   Article.unread
  #     |> Repo.all
  #     |> Enum.shuffle
  #     |> List.first
  # end

  # defp pluck_article(category) do
  #   :random.seed(:os.timestamp)

  #   Article.in_category(category)
  #     |> Article.unread
  #     |> Repo.all
  #     |> Enum.shuffle
  #     |> List.first
  # end
end

