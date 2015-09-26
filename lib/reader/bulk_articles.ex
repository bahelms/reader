defmodule Reader.BulkArticles do
  alias Reader.Article

  @moduledoc """
  Functions for dealing with the bulk creation of articles.
  """

  @doc """
  Parses the string of article urls and merges them with the given category
  into a list of maps.
  """
  @spec parse(map) :: [%{url: String.t, category: String.t}]
  def parse(%{"bulk_articles" => urls, "category" => category}) do
    for url <- String.split(urls) do
      %{url: url, category: category}
    end
  end

  @doc """
  Converts a list of maps into a list of Article changesets
  """
  @spec to_changesets([map]) :: list
  def to_changesets(params_list) do
    Enum.map params_list, fn(params) ->
      Article.changeset(%Article{}, params)
    end
  end
end

