defmodule Reader.ArticleController do
  use Reader.Web, :controller
  alias Reader.Article
  alias Reader.BulkArticles
  alias Reader.ArticleNormalizer
  import Logger

  plug :scrub_params, "article" when action in [:create, :update]

  def index(conn, %{"category" => category}) do
    redirect conn, to: "/articles/#{pluck_article(category).id}"
  end

  def index(conn, _params) do
    articles = Reader.Repo.all(Article.articles_by_category)
    render conn, :index, articles: articles
  end

  def new(conn, _params) do
    changeset = Article.changeset(%Article{})
    render conn, :new, changeset: changeset, bulk_changeset: changeset
  end

  def show(conn, %{"id" => id}) do
    render conn, :show, article: Reader.Repo.get!(Article, id)
  end

  def create(conn, %{"article" => article_params}) do
    changeset = Article.changeset(%Article{}, article_params)
    bulk_changeset = Article.changeset(%Article{})

    case Reader.Repo.insert(changeset) do
      {:ok, _article} ->
        put_flash(conn, :info, "Article saved")
          |> redirect to: article_path(conn, :new)
      {:error, changeset} ->
        render conn, :new, changeset: changeset, bulk_changeset: bulk_changeset
    end
  end

  def update(conn, %{"id" => id, "article" => params}) do
    article = Repo.get!(Article, id)
    Article.changeset(article, ArticleNormalizer.boolean(params))
      |> Repo.update
    redirect conn, to: article_path(conn, :show, article)
  end

  def create_bulk(conn, %{"article" => bulk_params}) do
    BulkArticles.parse(bulk_params)
      |> BulkArticles.to_changesets
      |> Enum.map fn(changeset) ->
        Reader.Repo.insert(changeset)
      end

    put_flash(conn, :info, "Bulk articles saved")
      |> redirect to: "/articles/new"
  end

  defp pluck_article("random") do
    :random.seed(:os.timestamp)

    Article.unread
      |> Reader.Repo.all
      |> Enum.shuffle
      |> List.first
  end

  defp pluck_article(category) do
    :random.seed(:os.timestamp)

    Article.in_category(category)
      |> Article.unread
      |> Reader.Repo.all
      |> Enum.shuffle
      |> List.first
  end
end

