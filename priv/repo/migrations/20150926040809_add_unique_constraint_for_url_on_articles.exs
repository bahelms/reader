defmodule Reader.Repo.Migrations.AddUniqueConstraintForUrlOnArticles do
  use Ecto.Migration

  def change do
    create unique_index(:articles, [:url])
  end
end
