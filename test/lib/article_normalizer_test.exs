defmodule Reader.ArticleNormalizerTest do
  use ExUnit.Case
  alias Reader.ArticleNormalizer

  test "boolean/1 converts a map with text params into booleans" do
    read = ArticleNormalizer.boolean(%{"read" => "Read"})
    favorite = ArticleNormalizer.boolean(%{"favorite" => "UnfavoRite"})
    assert read == %{"read" => true}
    assert favorite == %{"favorite" => false}
  end
end
