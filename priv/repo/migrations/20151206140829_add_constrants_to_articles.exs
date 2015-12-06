defmodule Reader.Repo.Migrations.AddConstrantsToArticles do
  use Ecto.Migration

  def change do
    alter table(:articles) do
      modify :url, :text, null: false
      modify :category, :text, null: false
    end
  end
end
