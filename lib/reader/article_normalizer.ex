defmodule Reader.ArticleNormalizer do
  @moduledoc """
  Normalizes request params for articles.
  """

  @doc """
  Turns values of 'Read/Unread' into booleans.
  """
  @spec boolean(map) :: map
  def boolean(%{"read" => read} = params) do
    Map.merge(params, %{"read" => read_value(read)})
  end

  @doc """
  Turns values of 'Favorite/Unfavorite' into booleans.
  """
  @spec boolean(map) :: map
  def boolean(%{"favorite" => favorite} = params) do
    Map.merge(params, %{"favorite" => favorite_value(favorite)})
  end

  defp read_value(value) do
    case String.downcase(value) do
      "unread" -> false
      "read"   -> true
    end
  end

  defp favorite_value(value) do
    case String.downcase(value) do
      "favorite"   -> true
      "unfavorite" -> false
    end
  end
end

