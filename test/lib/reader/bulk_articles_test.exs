defmodule Reader.BulkArticlesTest do
  use ExUnit.Case
  alias Reader.{BulkArticles, Article}

  @doc "parse/1"
  test "parses a string of urls into a list of maps with the category" do
    urls = "www.test.com\r\nhttp://www.heythere.com\r\nwhat.org/article"
    expected_result = [
      %{url: "www.test.com", category: "test"},
      %{url: "http://www.heythere.com", category: "test"},
      %{url: "what.org/article", category: "test"} ]

    assert BulkArticles.parse(urls, "test") == expected_result
  end

  @doc "to_changesets/1"
  test "converts a list of maps into a list of %Article{} changesets" do
    maps = [
      %{url: "test.com",    category: "test"},
      %{url: "another.com", category: "test"}]

    expected_result = [
      Article.changeset(%Article{}, %{url: "test.com",    category: "test"}),
      Article.changeset(%Article{}, %{url: "another.com", category: "test"})]

    assert BulkArticles.to_changesets(maps) == expected_result
  end
end

