defmodule Reader.ArticleSanitizerTest do
  use ExUnit.Case
  alias Reader.ArticleSanitizer

  test "removes query string crap from url" do
    res = %{"url" => "http://www.test.com?utm_source=rubyweekly&utm_medium=email"}
      |> ArticleSanitizer.sanitize_url
    assert res == %{"url" => "http://www.test.com"}
  end

  test "converts category to snake case" do
    res = %{"category" => "Hello there SirMadam!"}
      |> ArticleSanitizer.sanitize_category
    assert res["category"] == "hello_there_sirmadam!"
  end

  test "clean_params/1 does it all" do
    res = %{
      "url" => "http://what.com?some=crap&other=nonsense",
      "category" => "What the hey_There"
    } |> ArticleSanitizer.clean_params

    assert res["url"] == "http://what.com"
    assert res["category"] == "what_the_hey_there"
  end

  test "does nothing when url or category are not given" do
    assert ArticleSanitizer.clean_params(%{hey: "there"}) == %{hey: "there"}
  end
end
