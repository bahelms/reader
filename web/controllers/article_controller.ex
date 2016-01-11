defmodule Reader.ArticleController do
  use Reader.Web, :controller
  alias Reader.Article
  alias Reader.BulkArticles
  import Logger
  import Ecto.Query

  plug :scrub_params, "article" when action in [:create, :update]

  def index(conn, _params) do
    render conn, articles: Repo.all(Article.articles_by_category)
  end

  def show(conn, %{"id" => id}) do
    render conn, article: Repo.get!(Article, id)
  end

  # def create(conn, article_params) do
  #   changeset = Article.changeset(%Article{}, article_params)
  #   bulk_changeset = Article.changeset(%Article{})

  #   case Repo.insert(changeset) do
  #     {:ok, article} ->
  #       Reader.ArticleWorker.update_title(article)
  #       put_flash(conn, :info, "Article saved")
  #         |> redirect to: article_path(conn, :new)
  #     {:error, changeset} ->
  #       render conn, :new, changeset: changeset, bulk_changeset: bulk_changeset
  #   end
  # end

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
      |> Enum.map(&titleize/1)
    json conn, %{categories: ["Random" | categories]}
  end

  defp titleize(string) do
    string
      |> String.split("_")
      |> Enum.map(&(String.capitalize(&1)))
      |> Enum.join(" ")
  end

  # def index(conn, %{"category" => category}) do
  #   article_id = pluck_article(String.downcase(category)).id
  #   redirect conn, to: "/articles/#{article_id}"
  # end

  # def new(conn, _params) do
  #   changeset = Article.changeset(%Article{})
  #   render conn, :new, changeset: changeset, bulk_changeset: changeset
  # end

  # def edit(conn, %{"id" => id}) do
  #   article = Repo.get!(Article, id)
  #   changeset = Article.changeset(article)
  #   render conn, :edit, article: article, changeset: changeset
  # end

  # def update_status(conn, %{"id" => id, "article" => params}) do
  #   article = Repo.get!(Article, id)
  #   Article.changeset(article, ArticleNormalizer.boolean(params))
  #     |> Repo.update
  #   redirect conn, to: article_path(conn, :show, article)
  # end

  # def create_bulk(conn, %{"article" => bulk_params}) do
  #   BulkArticles.parse(bulk_params)
  #     |> BulkArticles.to_changesets
  #     |> Enum.map(fn(changeset) ->
  #       {:ok, article} = Repo.insert(changeset)
  #       article
  #     end)
  #     |> Enum.each(&Reader.ArticleWorker.update_title/1)

  #   put_flash(conn, :info, "Bulk articles saved")
  #     |> redirect to: "/articles/new"
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

