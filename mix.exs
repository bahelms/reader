defmodule Reader.Mixfile do
  use Mix.Project

  def project do
    [app: :reader,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: {Reader, []},
     applications: [:phoenix, :phoenix_html, :cowboy, :logger, :httpoison,
                    :phoenix_ecto, :postgrex]]
  end

  # Specifies which paths to compile per environment
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [{:cowboy, "~> 1.0"},
     {:corsica, "~> 0.4.0"},
     {:floki, "~> 0.5.0"},
     {:httpoison, "~> 0.7.4"},
     {:phoenix, "~> 1.1.2"},
     {:phoenix_ecto, "~> 2.0"},
     {:phoenix_html, "~> 2.3"},
     {:phoenix_live_reload, "~> 1.0", only: :dev},
     {:postgrex, "~> 0.10"},]
  end
end
