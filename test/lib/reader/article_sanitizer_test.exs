defmodule Reader.ArticleSanitizerTest do
  use ExUnit.Case
  alias Reader.ArticleSanitizer

  ### clean_article/1 ###

  setup do
    article_params = %{
      "url" => "http://what.com?some=crap&other=nonsense",
      "category" => "What the hey_There"
    }
    bulk_params = %{
      "bulk_articles" => %{
        "category" => "Hey there SirMadam!",
        "urls" => [
          "http://google.com?hey=there",
          "http://yahoo.com?hey=there&what=now",
          "http://lycos.com?go=away"
        ] |> Enum.join("\n")
      }
    }

    {:ok, article_params: article_params, bulk_params: bulk_params}
  end

  test "removes query string crap from url", %{article_params: params} do
    res = ArticleSanitizer.clean_article(params)
    assert res["url"] == "http://what.com"
  end

  test "converts category to snake case", %{article_params: params} do
    res = ArticleSanitizer.clean_article(params)
    assert res["category"] == "what_the_hey_there"
  end

  test "does nothing when url or category are not given" do
    assert ArticleSanitizer.clean_article(%{hey: "there"}) == %{hey: "there"}
  end

  ### clean_bulk_articles/1 ###

  test "removes query string crap from all urls", %{bulk_params: params} do
    res = ArticleSanitizer.clean_bulk_articles(params)
    clean_urls = "http://google.com\nhttp://yahoo.com\nhttp://lycos.com"
    assert res["bulk_articles"]["urls"] == clean_urls
  end

  test "converts category to snake case for bulk", %{bulk_params: params} do
    res = ArticleSanitizer.clean_bulk_articles(params)
    assert res["bulk_articles"]["category"] == "hey_there_sirmadam!"
  end

  test "does nothing when urls or category are not given" do
    params = %{"bulk_articles" => %{what: "me worry?"}}
    assert ArticleSanitizer.clean_bulk_articles(params) == params
  end
end
