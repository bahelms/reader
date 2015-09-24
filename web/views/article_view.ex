defmodule Reader.ArticleView do
  use Reader.Web, :view

  def article_status(%{read: true, favorite: false}), do: "info"
  def article_status(%{favorite: true}), do: "success"
  def article_status(_), do: ""
end
