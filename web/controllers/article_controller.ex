defmodule Reader.ArticleController do
  use Reader.Web, :controller
  alias Reader.Article
  import Logger

  plug :scrub_params, "article" when action in [:create, :update]

  def index(conn, %{"category" => category}) do
    render conn, "_article_data.html", article: pluck_article(category)
  end

  def index(conn, _params) do
    articles = Reader.Repo.all(Article.articles_by_category)
    render conn, :index, articles: articles
  end

  def new(conn, _params) do
    changeset = Article.changeset(%Article{})
    render conn, :new, changeset: changeset, bulk_changeset: changeset
  end

  def create(conn, %{"article" => %{"bulk_articles" => articles}}) do
    # parse articles
    # save each
    put_flash(conn, :info, "Bulk articles saved")
      |> redirect to: "/articles/new"
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

