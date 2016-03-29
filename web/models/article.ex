defmodule Reader.Article do
  use Reader.Web, :model
  import Ecto.Query

  @derive {Poison.Encoder, only: [
    :id, :url, :category, :title, :read, :favorite, :inserted_at]}

  schema "articles" do
    field :url, :string
    field :category, :string
    field :title, :string, default: "NO TITLE"
    field :read, :boolean, default: false
    field :favorite, :boolean, default: false
    timestamps
  end

  @required_fields ~w(url category title)
  @optional_fields ~w(read favorite)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
      |> cast(params, @required_fields, @optional_fields)
      |> unique_constraint(:url)
  end

  def articles_by_category do
    __MODULE__
      |> order_by([a], a.category)
  end

  def distinct_categories do
    __MODULE__
      |> group_by([a], a.category)
      |> select([a], a.category)
  end

  def in_category(query \\ __MODULE__, category) do
    where(query, [a], a.category == ^category)
  end

  def unread(query \\ __MODULE__) do
    where(query, [a], a.read == false)
  end

  def ordered_by_category(query \\ __MODULE__) do
    order_by(query, [a], asc: a.category)
  end
end

