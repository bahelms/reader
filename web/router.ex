defmodule Reader.Router do
  use Reader.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Reader do
    pipe_through :api

    get "/article_categories", ArticleController, :article_categories
    resources "articles", ArticleController, except: [:edit, :create]
    # put "/article_status/:id", ArticleController, :update_status
    # post "/bulk_articles", ArticleController, :create_bulk
  end
end
