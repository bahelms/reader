defmodule Reader.Endpoint do
  use Phoenix.Endpoint, otp_app: :reader

  socket "/socket", Reader.UserSocket

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phoenix.digest
  # when deploying your static files in production.
  # plug Plug.Static,
  #   at: "/", from: :reader, gzip: false,
  #   only: ~w(css fonts images js favicon.ico robots.txt)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_reader_key",
    signing_salt: "NqrXrQQX"

  frontend_origin = case Mix.env do
    :dev  -> "http://localhost:8080"
    :test -> "http://localhost:8080"
    :prod -> ""
  end

  plug Corsica, origins: frontend_origin, allow_headers: ["accept"]
  plug Reader.Router
end
