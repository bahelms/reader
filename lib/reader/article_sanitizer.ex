defmodule Reader.ArticleSanitizer do
  @moduledoc """
  Transforms incoming parameters for articles into nicely formatted data
  """

  @doc """
  Sanitizes url
  """
  def clean_params(params) do
    params
      |> sanitize_url
      |> sanitize_category
  end

  @doc """
  Removes extraneous query string clutter from article URL
  """
  def sanitize_url(%{"url" => _} = params) do
    Map.update!(params, "url", &(String.split(&1, "?") |> List.first))
  end
  def sanitize_url(params), do: params

  @doc """
  Converts the category string to snake case
  """
  def sanitize_category(%{"category" => _} = params) do
    Map.update! params, "category", fn(category) ->
      category
        |> String.replace(" ", "_")
        |> String.downcase
    end
  end
  def sanitize_category(params), do: params
end
