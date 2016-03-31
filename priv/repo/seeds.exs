# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Reader.Repo.insert!(%SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

if Mix.env == :dev do
  Reader.Repo.delete_all(Reader.Article)

  categories = ["elixir", "phoenix", "ruby", "rails", "distributed_systems", "otp"]
  domains    = ["org", "com", "net", "biz", "io"]

  for category <- categories, domain <- domains do
    %Reader.Article{
      url: "http://www.#{category}.#{domain}",
      title: "#{Phoenix.Naming.humanize(category)} #{String.upcase(domain)}",
      category: category
    } |> Reader.Repo.insert!
  end
end
