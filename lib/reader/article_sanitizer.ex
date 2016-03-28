defmodule Reader.ArticleSanitizer do
  @moduledoc """
  Transforms incoming parameters for articles into nicely formatted data
  """

  @doc """
  Sanitizes url, and category params for one article
  """
  def clean_article(params) do
    params
      |> sanitize_url
      |> sanitize_category
  end

  @doc """
  Sanitizes urls and category for many articles
  """
  def clean_bulk_articles(params) do
    Map.update! params, "bulk_articles", fn(articles) ->
      articles
        |> _sanitize_bulk_urls
        |> sanitize_category
    end
  end

  @doc """
  Removes extraneous query string clutter from article URL and updates map
  """
  def sanitize_url(%{"url" => _} = params) do
    Map.update!(params, "url", &sanitize_url/1)
  end

  @doc """
  Removes extraneous query string clutter from article URL string
  """
  def sanitize_url(url) when is_binary(url) do
    url
      |> String.split("?")
      |> List.first
  end

  def sanitize_url(params), do: params

  @doc """
  Converts the category string to snake case and updates map
  """
  def sanitize_category(%{"category" => _} = params) do
    Map.update!(params, "category", &sanitize_category/1)
  end

  @doc """
  Converts the category string to snake case
  """
  def sanitize_category(category) when is_binary(category) do
    category
      |> String.replace(" ", "_")
      |> String.downcase
  end

  def sanitize_category(params), do: params

  defp _sanitize_bulk_urls(%{"urls" => _} = params) do
    Map.update!(params, "urls", &_sanitize_bulk_urls/1)
  end

  defp _sanitize_bulk_urls(urls) when is_binary(urls) do
    urls
      |> String.split("\n")
      |> Enum.map(&sanitize_url/1)
      |> Enum.join("\n")
  end

  defp _sanitize_bulk_urls(params), do: params
end
