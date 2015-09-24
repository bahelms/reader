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

Reader.Repo.delete_all(Reader.Article)

articles = [
  %Reader.Article{url: "http://www.elixir.com", title: "A fantastic article about Elixir", category: "elixir"},
  %Reader.Article{url: "http://www.elixir.org", title: "A fantastic article about Elixir", category: "elixir"},
  %Reader.Article{url: "http://www.ruby.com", title: "A fantastic article about Ruby", category: "ruby"},
  %Reader.Article{url: "http://www.rails.com", title: "A fantastic article about Rails", category: "rails"},
  %Reader.Article{
    url: "http://blog.acolyer.org/2015/01/13/unikernels-library-operating-systems-for-the-cloud/",
    title: "Unikernels: Library Operating Systems for the Cloud | the morning paper",
    category: "distributed_systems"},
  %Reader.Article{url: "http://www.abc.com", title: "A fantastic article about hard CS", category: "computer_science"},
  %Reader.Article{url: "http://www.nbc.com", title: "An article about distributed systems", category: "distributed_systems"},
  %Reader.Article{url: "http://www.amazon.com", title: "An article about AWS", category: "aws"}
]

for article <- articles, do: Reader.Repo.insert!(article)

