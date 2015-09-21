defmodule Reader.ArticleTest do
  use Reader.ModelCase

  alias Reader.Article

  @valid_attrs %{category: "some content", favorite: true, read: true, title: "some content", url: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Article.changeset(%Article{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Article.changeset(%Article{}, @invalid_attrs)
    refute changeset.valid?
  end
end
