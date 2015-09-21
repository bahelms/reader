defmodule Reader.Repo.Migrations.CreateArticle do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :url, :text
      add :category, :text
      add :title, :text
      add :read, :boolean, default: false
      add :favorite, :boolean, default: false

      timestamps
    end

  end
end
