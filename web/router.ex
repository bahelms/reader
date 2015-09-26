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
    pipe_through :browser

    get "/", HomeController, :index
    resources "articles", ArticleController, only: [:new, :index, :create, :show]
    post "/bulk_articles", ArticleController, :create_bulk
  end

  # Other scopes may use custom stacks.
  # scope "/api", Reader do
  #   pipe_through :api
  # end
end
